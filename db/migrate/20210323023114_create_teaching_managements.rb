class CreateTeachingManagements < ActiveRecord::Migration[6.0]
  def change
    create_table :teaching_managements do |t|
      t.references :teacher, foreign_key: { to_table: :users }, null: false, index: true
      t.references :study_class, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
