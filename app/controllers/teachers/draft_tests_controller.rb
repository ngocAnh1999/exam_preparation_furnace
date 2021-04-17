class Teachers::DraftTestsController < TeachersController
  skip_before_action :verify_authenticity_token, :only => [:update]
  before_action :load_draft_test, only: %i[edit update new_test]
  before_action :load_references, only: :new_test

  def index
    @draft_tests = current_user.draft_tests.page params[:page]
    render partial: "teachers/draft_tests/table", draft_tests: @draft_tests
  end

  def new
    @draft_test = DraftTest.new
  end

  def create
    @draft_test = current_user.draft_tests.build questions: []
    if @draft_test.save
      redirect_to edit_teachers_draft_test_path(id: @draft_test.id)
    else
      flash[:alert] = "Create failed!"
      redirect_to teachers_tests_path
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      @draft_test.update draft_test_params_converted
      @validates = @draft_test.errors.messages unless @draft_test.valid?(:test)
      format.js
    end
  end

  def search_chapters
    @list_chapters = Chapter.by_subject_and_level params[:subject], params[:level]
    respond_to do |format|
      format.json { render json: @list_chapters }
    end
  end

  def new_test
    @test = current_teacher.tests.build
  end

  def teacher_same_subjects
    @teachers = current_school.subjects.find(params[:subject_id])
                              &.teachers&.pluck(:id, :first_name, :last_name)
                              .uniq.reject {|item| params[:teacher_ids]&.include?(item[0].to_s) }
    respond_to do |format|
      format.json { render json: @teachers }
    end
  end

  private

  def load_draft_test
    @draft_test = current_user.draft_tests.find_by id: params[:id]
  end

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
      :shuffle_count,
      :title,
      :description,
      :unlimited_flag,
      questions: [
        :content,
        :suggestion,
        :question_type,
        answers_attributes: [:content, :is_correct, :position]
      ]
    )
  end

  def draft_test_params_converted
    convert_params = draft_test_params
    convert_params[:start_time] = datetime_convert convert_params[:start_time]
    convert_params[:due_time] = datetime_convert convert_params[:due_time]
    convert_params
  end

  def datetime_convert str
    Time.zone.strptime(str, Settings.test.datime_format)
  end
end
