class CreateStudyClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :study_classes do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_reference :study_classes, :semester, foreign_key: true
  end
end
