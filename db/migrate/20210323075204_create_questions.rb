class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :content, null: false
      t.string :content_image
      t.integer :difficulty
      t.string :suggestion
      t.integer :type
      t.integer :databank_type
      t.references :teacher, foreign_key: { to_table: :users }, null: false, index: true

      t.timestamps
    end
  end
end
