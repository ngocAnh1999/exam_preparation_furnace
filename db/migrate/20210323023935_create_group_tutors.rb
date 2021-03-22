class CreateGroupTutors < ActiveRecord::Migration[6.0]
  def change
    create_table :group_tutors do |t|
      t.string :name, null: false
      t.string :subject, null: false
      t.references :teacher, foreign_key: { to_table: :users }, null: false, index: true

      t.timestamps
    end
  end
end
