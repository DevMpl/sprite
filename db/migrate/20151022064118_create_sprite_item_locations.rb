class CreateSpriteItemLocations < ActiveRecord::Migration
  def change
    create_table :sprite_item_locations do |t|

      t.integer :item_id
      t.integer :city_id
      t.string :address
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6

      t.timestamps null: false
    end
  end
end
