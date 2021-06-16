class CreateMarks < ActiveRecord::Migration[6.0]
  def change
    create_table :marks do |t|
      t.string :name, null: false
      t.decimal :rate, precision: 5, scale: 2, null: false
      t.references :school, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
