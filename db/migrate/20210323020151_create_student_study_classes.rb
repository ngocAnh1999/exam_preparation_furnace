class CreateStudentStudyClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :student_study_classes do |t|
      t.references :student, foreign_key: { to_table: :users }, null: false, index: true
      t.references :study_class, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
