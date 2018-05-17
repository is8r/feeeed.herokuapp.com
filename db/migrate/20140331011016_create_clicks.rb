class CreateClicks < ActiveRecord::Migration[4.2]
  def change
    create_table :clicks do |t|
      t.integer :count

      t.timestamps
    end
  end
end
