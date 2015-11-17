module Sprite
	module ItemCategoriesHelper

	  def nested_categories(categories)
	    categories.map do |category, sub_categories|
	        render(category) + nested_categories(sub_categories)
	    end.join.html_safe
	  end

	  def category_name_spacer(categories)
	    spacer = '--'
	    hoge = categories.flatten.map do|category|
	      category.name = (category.parented_id.nil?) ? "#{category.name}" : "#{spacer * category.ancestry_depth.to_i} #{category.name}"
	      category
	    end
	  end

	end
end