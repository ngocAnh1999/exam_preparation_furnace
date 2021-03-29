class CreateLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels do |t|
      t.string :name
      t.references :school, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
