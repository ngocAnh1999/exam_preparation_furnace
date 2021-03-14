class CreateJoinTableUserSchools < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :schools do |t|
      # t.index [:user_id, :school_id]
      # t.index [:school_id, :user_id]
    end
  end
end
