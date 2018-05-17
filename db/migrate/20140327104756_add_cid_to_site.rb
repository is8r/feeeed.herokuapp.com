class AddCidToSite < ActiveRecord::Migration[4.2]
  def change
    add_column :sites, :cid, :integer
  end
end
