class CreateStudentGroupTutors < ActiveRecord::Migration[6.0]
  def change
    create_table :student_group_tutors do |t|
      t.references :student, foreign_key: { to_table: :users }, index: true, null: false
      t.references :group_tutor, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
