class CreateSemesters < ActiveRecord::Migration[6.0]
  def change
    create_table :semesters do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
    add_reference :semesters, :school, foreign_key: true
  end
end
