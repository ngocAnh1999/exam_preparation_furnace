class Teachers::DraftTestsController < TeachersController
  before_action :load_references, only: :new

  def index
    @draft_tests = current_user.draft_tests.page params[:page]
    render partial: "teachers/draft_tests/table", draft_tests: @draft_tests
  end

  def new
    @draft_test = DraftTest.new
    @question = Question.new
    @answer = @question.answers.build
  end

  def create
    binding.pry
  end

  def search_chapters
    @list_chapters = Chapter.by_subject_and_level params[:subject], params[:level]
    respond_to do |format|
      format.json { render json: @list_chapters }
    end
  end

  private

  def load_references
    @list_subjects = current_user.subjects.uniq.pluck(:name, :id)
    @list_levels = current_user.levels.uniq.pluck(:name, :id)
    @list_marks = current_user.marks.uniq.pluck(:name, :id)
  end

  def draft_test_params
    params.require(:draft_test).permit(
      :start_time,
      :due_time,
      :doing_time,
      :chapter_id,
      :shuffle_count,
      :title,
      :description,
      :unlimited_flag,
      :mark_id,
      questions: [
        :content,
        :suggestion,
        :type,
        answers_attributes: [:content, :is_correct, :position]
      ]
    )
  end
  # params[:draft_test][:questions][][:content]
  # params[:draft_test][:questions][][:answers][][:content]
end
