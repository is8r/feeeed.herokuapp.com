class AddUrlOriginalToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :url_original, :text
  end
end
