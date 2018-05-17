class AddCategoryIdToSites < ActiveRecord::Migration[4.2]
  def self.up
    add_column(:sites, :category_id, :integer)
    add_index(:sites, :category_id)
  end

  def self.down
    remove_index(:sites, :column => :category_id)
    remove_column(:sites, :category_id)
  end
end
