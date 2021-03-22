class CreateStudentSectionClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :student_section_classes do |t|
      t.references :student, foreign_key: { to_table: :users }, null: false, index: true
      t.references :section_class, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
