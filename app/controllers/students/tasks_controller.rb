class Students::TasksController < StudentsController
  before_action :load_task, except: :index
  before_action :doing_task_permission, only: %i[edit update]
  before_action :before_doing_task_permission, only: :before_doing_task
  before_action :after_doing_task_permission, only: :after_doing_task
  before_action :view_score_permission, only: :show

  def index
    @tasks = current_user.tasks.includes(assigned_group: :test)
  end

  def show
    @test = @task.assigned_group.test
  end

  def edit
    @task.update started_at: Time.zone.now unless @task.started_at?
  end

  def update
    respond_to do |format|
      @task.assign_attributes(ended_at: Time.zone.now) if params[:submit_flag] == "true"

      if @task.update permit_task
        if params[:submit_flag] == "true"
          format.html { redirect_to after_doing_task_students_task_path, notice: "Chúc mừng bạn đã nộp bài thành công!" }
        else
          format.html { render :edit }
        end
      else
        format.html { render :edit, alert: "Có lỗi trong lúc nộp bài" }
      end
    end
  end

  def before_doing_task; end

  def after_doing_task; end

  private

  def load_task
    @task = current_user.tasks.find(params[:id])
  end

  def permit_task
    params.require(:task).permit(
      answers: [
        :id,
        :content,
        :suggestion,
        :question_type,
        :score,
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

  def doing_task_permission
    time_now = Time.zone.now
    if time_now < @task.test_start_time
      flash[:alert] = "Chưa đến giờ làm bài"
      redirect_to before_doing_task_students_task_path(id: @task.id)
    elsif @task.submitted? || @task.expired?
      flash[:notice] = "Bạn đã kết thúc bài thi của mình"
      redirect_to after_doing_task_students_task_path(id: @task.id)
    end
  end

  def after_doing_task_permission
    return if @task.submitted? || @task.expired?

    flash[:alert] = "Bài kiểm tra của bạn chưa kết thúc"
    redirect_to before_doing_task_students_task_path(id: @task.id)
  end

  def before_doing_task_permission
    return if !@task.submitted? && !@task.expired?

    flash[:notice] = "Thời gian làm bài đã kết thúc"
    redirect_to after_doing_task_students_task_path(id: @task.id)
  end

  def view_score_permission
    return if @task.is_published?

    flash[:alert] = "Bài thi chưa được chấm"
    redirect_to after_doing_task_students_task_path
  end
end
