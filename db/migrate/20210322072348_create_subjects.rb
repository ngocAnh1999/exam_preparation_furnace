class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.string :name, null: false, index: true

      t.timestamps
    end
    add_reference :subjects, :school, foreign_key: true
  end
end
