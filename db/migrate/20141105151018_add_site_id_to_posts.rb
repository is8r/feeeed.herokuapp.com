class AddSiteIdToPosts < ActiveRecord::Migration[4.2]
  def self.up
    add_column(:posts, :site_id, :integer)
    add_index(:posts, :site_id)
  end

  def self.down
    remove_index(:posts, :column => :site_id)
    remove_column(:posts, :site_id)
  end
end
