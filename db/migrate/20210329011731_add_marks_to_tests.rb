class AddMarksToTests < ActiveRecord::Migration[6.0]
  def change
    add_reference :tests, :mark
  end
end
