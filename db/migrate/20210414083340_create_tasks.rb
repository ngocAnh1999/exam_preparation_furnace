class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :student, null: false, index: true
      t.references :assigned_group, null: false, index: true
      t.datetime :started_at
      t.datetime :ended_at
      t.float :score
      t.json :answers
      t.integer :task_status
      t.string :teacher_comment

      t.timestamps
    end
  end
end
