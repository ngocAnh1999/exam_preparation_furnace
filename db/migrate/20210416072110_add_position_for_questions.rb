class AddPositionForQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :position, :integer
  end
end
