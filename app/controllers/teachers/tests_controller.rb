class Teachers::TestsController < TeachersController
  before_action :load_draft_test, only: :create
  before_action :load_test, only: %i[send_test assigned_test]

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

  private

  def test_params
    params.require(:test).permit(
      :chapter_id,
      :difficulty,
      :mark_id,
      :shared_status
    )
  end

  def load_draft_test
    @draft_test = current_user.draft_tests.find params[:draft_test_id]
  end

  def load_test
    @test = current_user.tests.find params[:id]
  end
end
