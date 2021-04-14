class CreateChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :chapters do |t|
      t.string :name
      t.references :level, null: false, index: true
      t.references :subject, null: false, index: true

      t.timestamps
    end
  end
end
