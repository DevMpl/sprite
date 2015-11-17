class CreateSpriteItemItemCategories < ActiveRecord::Migration
  def change
    create_table :sprite_item_item_categories do |t|

      t.integer :item_id
      t.integer :item_category_id

      t.timestamps null: false
    end
  end
end
