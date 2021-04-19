class AddStudentAnswerToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :student_answers, :json
  end
end
