class SendTestService
  def initialize current_test, params
    @test = current_test
    @groupable_type = params[:groupable_type]
    @groupable_ids = params[:groupable_ids]
    @questions = questions
    @answers = answers
    @groups = groupables
  end

  def perform
    return if @groups.blank?

    return if assigned_group_ids.present?

    AssignedGroup.bulk_import! @groups
    Task.import! shuffle_tasks
  end

  private

  def groupables
    groups = @groupable_ids&.map do |id|
      {
        groupable_type: @groupable_type,
        groupable_id: id,
        test_id: @test.id
      }
    end
  end

  def shuffle_tasks
    list_student_ids = student_ids&.flatten&.uniq
    tasks = assigned_group_ids&.map do |assigned_group_id|
      list_student_ids&.map do |student_id|
        {
          student_id: student_id,
          assigned_group_id: assigned_group_id,
          answers: shuffle_questions.shuffle(random: random_shuffle(student_id)),
          task_status: 0
        }
      end
    end.flatten
  end

  def student_ids
    students = @groupable_ids&.map do |id|
      @groupable_type.constantize.find(id.to_i).students.ids
    end
  end

  def assigned_group_ids
    assigned_ids = AssignedGroup.where(
      groupable_type: @groupable_type,
      groupable_id: @groupable_ids,
      test_id: @test.id
    ).pluck :id
  end

  def random_shuffle(code_rand)
    shuffle_count = @test.shuffle_count
    Random.new(code_rand%shuffle_count)
  end

  def questions
    @questions = @test.questions.select(
      :id,
      :content,
      :content_image,
      :suggestion,
      :question_type,
      :teacher_id,
      :score,
      :position)
  end

  def answers
    @answers = Answer.where(question_id: @questions.ids).select(
      :id,
      :content,
      :is_correct,
      :content_image,
      :position,
      :question_id
    )&.as_json
  end

  def shuffle_questions
    list_questions = []
    @questions&.as_json&.each do |item|
      item["answers"] = @answers.select {|answer| answer["question_id"] == item["id"] }
                                &.shuffle(random: random_shuffle(item["id"]))
      list_questions << item
    end
    list_questions
  end
end
