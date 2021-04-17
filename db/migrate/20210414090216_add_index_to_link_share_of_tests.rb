class AddIndexToLinkShareOfTests < ActiveRecord::Migration[6.0]
  def change
    add_index :tests, :link_share
  end
end
