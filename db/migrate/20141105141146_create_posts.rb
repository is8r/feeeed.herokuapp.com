class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :description
      t.text :url
      t.datetime :posted_at
      t.text :image_url

      t.timestamps
    end
  end
end
