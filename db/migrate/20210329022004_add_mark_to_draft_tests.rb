class AddMarkToDraftTests < ActiveRecord::Migration[6.0]
  def change
    add_reference :draft_tests, :mark
  end
end
