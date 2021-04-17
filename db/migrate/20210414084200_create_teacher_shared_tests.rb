class CreateTeacherSharedTests < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_shared_tests do |t|
      t.references :teacher, null: false, index: true
      t.references :test, null: false, index: true

      t.timestamps
    end
  end
end
