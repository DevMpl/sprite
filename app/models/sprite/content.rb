class Sprite::Content < ActiveRecord::Base
	
	validate :slug_unique
	
	def slug_unique

	end
	
end
