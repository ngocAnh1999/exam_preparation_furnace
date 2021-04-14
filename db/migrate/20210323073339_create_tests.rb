class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :title
      t.string :description
      t.datetime :start_time
      t.datetime :due_time
      t.integer :doing_time
      t.integer :shuffle_count, null: false, default: 1
      t.boolean :unlimited_flag, default: false
      t.integer :difficulty
      t.integer :shared_status, default: 0
      t.string :link_share
      t.references :teacher, foreign_key: { to_table: :users }, null: false, index: true
      t.references :chapter, foreign_key: true, null: true, index: true

      t.timestamps
    end
  end
end
