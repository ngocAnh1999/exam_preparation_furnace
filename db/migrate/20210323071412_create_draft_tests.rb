class CreateDraftTests < ActiveRecord::Migration[6.0]
  def change
    create_table :draft_tests do |t|
      t.string :title
      t.json :content_data
      t.integer :difficulty
      t.string :description
      t.datetime :start_time
      t.datetime :due_time
      t.integer :doing_time
      t.integer :shuffle_count, null: false, default: 1
      t.boolean :unlimited_flag, default: false
      t.references :teacher, foreign_key: { to_table: :users }, null: false, index: true
      t.references :chapter, foreign_key: true, null: true, index: true

      t.timestamps
    end
  end
end
