class Sprite::ItemItemCategory < ActiveRecord::Base
	belongs_to :item
	belongs_to :content, class_name: 'ItemCategory', foreign_key: 'item_category_id'
end