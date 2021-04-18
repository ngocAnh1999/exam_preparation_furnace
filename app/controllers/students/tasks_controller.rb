class Students::TasksController < StudentsController
  before_action :load_task, except: :index
  before_action :doing_task_permission, only: %i[edit update]
  before_action :before_doing_task_permission, only: :before_doing_task
  before_action :after_doing_task_permission, only: :after_doing_task

  def index
    @tasks = current_user.tasks.includes(assigned_group: :test)
  end

  def show; end

  def edit
    # @task.update started_at: Time.zone.now unless @task.started_at?
    
  end

  def update; end

  def before_doing_task; end

  def after_doing_task; end

  private

  def load_task
    @task = current_user.tasks.find(params[:id])
  end

  def doing_task_permission
    time_now = Time.zone.now
    if time_now < @task.test_start_time
      flash[:alert] = "Chưa đến giờ làm bài"
      redirect_to before_doing_task_students_task_path(id: @task.id)
    elsif @task.submitted? || @task.expired?
      flash[:alert] = "Thời gian làm bài đã kết thúc"
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

    flash[:alert] = "Thời gian làm bài đã kết thúc"
    redirect_to after_doing_task_students_task_path(id: @task.id)
  end
end
