module PositionRebuild

		extend ActiveSupport::Concern

		included do

	    acts_as_list scope: 'ancestry = \'#{ancestry}\''

	    before_create :position_set_max
	    before_save :old_category_position_rebuild?
	    after_save :position_rebuild!

	    def old_category_position_rebuild?
	      if self.parented_id != self.parent_id
	        self.position = Object.const_get(type).count
	        old_object = Object.const_get(type).parented(self.parented_id).first
	          Object.const_get(type).after_update do
	            old_object.position_rebuild!
	          end
	        end
	    end

		  def position_rebuild!
		    Object.const_get(type).siblings_of(self).ascending.all.each_with_index do |category, id|
		      # update_columnはcallbackが呼ばれない
		      category.update_column(:position, "#{id.to_i + 1}")
		    end
		  end

		  def position_set_max
	      self.position = Object.const_get(type).parented(self.parented_id).count + 1
		  end

		end

end