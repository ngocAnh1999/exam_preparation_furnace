class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, comment: "User table" do |t|
      t.string :username, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :type, null: false, comment: "User role"
      t.string :email, null: false
      t.string :phone

      t.timestamps

      t.index :username, unique: true
      t.index :email, unique: true
    end
  end
end
