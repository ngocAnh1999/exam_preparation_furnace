class Teachers::TestsController < TeachersController
  before_action :load_draft_test, only: :create
  before_action :load_test, except: %i[index create]
  before_action :load_task, only: [:edit_task, :marking]

  def index
    @tests = current_user.tests.page params[:page]
  end

  def create
    ActiveRecord::Base.transaction do
      @test = current_user.tests.build test_params
      @test.assign_draft_attributes @draft_test
      @test.save!

      InsertRecordsService.new(@draft_test, current_user, @test, params[:teacher_ids]).perform
      @draft_test.destroy

      flash[:notice] = "create test success"
      redirect_to send_test_teachers_test_path(id: @test.id)
    end
  end

  def send_test
    @study_classes = current_user.classes.select :id, :name
    @group_tutors = current_user.group_tutors.select :id, :name
  end

  def assigned_test
    ActiveRecord::Base.transaction do
      SendTestService.new(@test, params).perform

      flash[:notice] = "Gửi đề thành công!"
      redirect_to teachers_root_path
    end
  end

  def list_tasks
    @tasks = @test.tasks.includes(:student, :assigned_group)
  end

  def edit_task
    render partial: "teachers/tests/form_edit_task"
  end

  def marking
    @task.update_and_map_score! task_params

    flash[:notice] = "Cập nhật điểm thành công!"
    redirect_to list_tasks_teachers_test_path(id: @test.id)
  end

  def publish_score
    ActiveRecord::Base.transaction do
      @assigned_group = @test.assigned_groups.find(params[:assigned_group_id])
      @assigned_group.update published_at: Time.zone.now unless @assigned_group.published_at?

      render partial: "teachers/tests/collapse_group", collection: @test.assigned_groups, as: :assigned_group
    end
  end

  private

  def test_params
    params.require(:test).permit(
      :chapter_id,
      :difficulty,
      :mark_id,
      :shared_status
    )
  end

  def task_params
    params.require(:task).permit(
      :teacher_comment,
      answers: [
        :id,
        :content,
        :suggestion,
        :question_type,
        :score,
        :mark,
        :text_answer,
        answers: [
          :id,
          :content,
          :is_correct,
          :check
        ]
      ]
    )
  end

  def load_draft_test
    @draft_test = current_user.draft_tests.find params[:draft_test_id]
  end

  def load_test
    @test = current_user.tests.find params[:id]
  end

  def load_task
    @task = @test.tasks.find(params[:task_id])
  end
end
