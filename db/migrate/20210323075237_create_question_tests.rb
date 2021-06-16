class CreateQuestionTests < ActiveRecord::Migration[6.0]
  def change
    create_table :question_tests do |t|
      t.references :question, foreign_key: true, null: false, index: true
      t.references :test, foreign_key: true, null: false, index: true
      t.float :score

      t.timestamps
    end
  end
end
