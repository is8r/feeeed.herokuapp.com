class AddUrlOriginalToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :url_original, :text
  end
end
