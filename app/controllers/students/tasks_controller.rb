class Students::TasksController < StudentsController
  def index
    @tasks = current_user.tasks.includes(assigned_group: :test)
  end

  def show; end

  def edit; end

  def update; end
end
