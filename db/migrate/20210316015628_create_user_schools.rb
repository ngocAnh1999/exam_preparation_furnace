class CreateUserSchools < ActiveRecord::Migration[6.0]
  def change
    create_table :user_schools do |t|
      t.references :user, index: true, foreign_key: true
      t.references :school, index: true, foreign_key: true

      t.timestamps
    end
  end
end
