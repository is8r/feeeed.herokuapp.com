class CreateSites < ActiveRecord::Migration[4.2]
  def change
    create_table :sites do |t|
      t.text :name
      t.text :url
      t.text :rss
      t.boolean :active

      t.timestamps
    end
  end
end
