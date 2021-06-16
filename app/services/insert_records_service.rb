class InsertRecordsService
  def initialize draft_test, teacher, test_record, teacher_ids
    @teacher = teacher
    @teacher_ids = teacher_ids
    @test = test_record
    @questions = draft_test.questions
    @question_records = nil
    @answers = []
  end

  def perform
    @questions = @questions&.each_with_index&.map do |question, index|
      question.merge(teacher_id: @teacher.id, position: index+1)
    end
    list_question = Question.bulk_import! @questions

    @question_records = @teacher.questions.by_contents(list_question.pluck("content"))
                                          .order position: :asc
    handle_answers list_question

    Answer.bulk_import! @answers.flatten

    import_test_questions

    import_shared_teacher if @test.limited?
  end

  private

  def handle_answers(list_question)
    list_question&.each_with_index do |question, q_index|
      next if question["answers_attributes"].blank?

      @answers << question["answers_attributes"]&.each_with_index&.map do |answer, ans_index|
        answer["is_correct"] = true if answer["is_correct"].present?
        answer.merge(question_id: @question_records[q_index].id, position: ans_index+1)
      end
    end
  end

  def import_test_questions
    question_tests = []
    @question_records.each do |question|
      question_tests << { question_id: question.id, test_id: @test.id }
    end

    QuestionTest.bulk_import! question_tests
  end

  def import_shared_teacher
    teacher_shared_tests = []
    @teacher_ids&.each do |id|
      teacher_shared_tests << { teacher_id: id, test_id: @test.id }
    end

    TeacherSharedTest.bulk_import! teacher_shared_tests
  end
end
