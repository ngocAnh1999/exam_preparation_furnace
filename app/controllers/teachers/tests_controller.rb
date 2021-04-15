class Teachers::TestsController < TeachersController
  before_action :load_draft_test, only: :create

  def index
    @tests = current_user.tests.page params[:page]
  end

  def create
    ActiveRecord::Base.transaction do
      @test = current_user.tests.build test_params
      @test.assign_draft_attributes @draft_test
      binding.pry
      # @test.save!
      # @draft_test.questions.each {|item| item.merge!(teacher_id: current_user.id) }
      # InsertRecordsService.new(@draft_test, current_user).perform
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
end
