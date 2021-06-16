class CreateAssignedGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :assigned_groups do |t|
      t.datetime :published_at
      t.references :groupable, polymorphic: true, null: false
      t.references :test, null: false, index: true

      t.timestamps
    end
  end
end
