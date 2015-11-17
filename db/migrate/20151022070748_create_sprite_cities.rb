class CreateSpriteCities < ActiveRecord::Migration
  def change
    create_table :sprite_cities do |t|
      t.string :name
      t.integer :prefecture_id, limit: 2
      t.string :code
      t.integer :is_ward, limit: 1, default: 0
      t.integer :is_other, limit: 1, default: 0
      t.integer :sequence, limit: 2

      t.timestamps
    end
  end
end
