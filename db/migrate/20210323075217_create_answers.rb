class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :is_correct
      t.string :content_image
      t.integer :position
      t.references :question, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
