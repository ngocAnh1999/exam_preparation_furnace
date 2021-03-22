class CreateStudyClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :study_classes do |t|
      t.string :name, null: false
      t.integer :grade

      t.timestamps
    end
    add_reference :study_classes, :semesters, foreign_key: true
  end
end
