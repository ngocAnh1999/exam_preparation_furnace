class InsertRecordsService
  def initialize draft_test, teacher
    @teacher = teacher
    @questions = draft_test.questions.map { |question| teacher.questions.build question }
  end

  def perform
    Question.import @questions
  end
end
