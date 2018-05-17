class AddPostIdToClicks < ActiveRecord::Migration[4.2]
  def self.up
    add_column(:clicks, :post_id, :integer)
    add_index(:clicks, :post_id)
  end

  def self.down
    remove_index(:clicks, :column => :post_id)
    remove_column(:clicks, :post_id)
  end
end
