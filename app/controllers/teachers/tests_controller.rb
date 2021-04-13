class Teachers::TestsController < TeachersController
  def index
    @tests = current_user.tests.page params[:page]
  end
end
