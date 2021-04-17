class ChangeTypeOfQuestions < ActiveRecord::Migration[6.0]
  def change
    rename_column :questions, :type, :question_type
  end
end
