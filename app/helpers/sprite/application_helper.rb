module Sprite
	module ApplicationHelper

	  def decorate(obj)
	    ActiveDecorator::Decorator.instance.decorate(obj)
	  end

	  def t_ja(attr)
	    t("activerecord.attributes.sprite/#{attr}")
	  end

	  def statuses
	    {
	      'public' => '公開',
	      'private' => '非公開',
	    }
	  end

	  def get_options(arr)
	    options = {}
	    arr.each.with_index(1){|a, i| options[a] = i }
	    options
	  end

	  def nl2br(txt)
	    sanitize(txt.gsub(/\n/,'<br />')) if txt.present?
	  end

	  def status_name(status_key)
	    statuses[status_key]
	  end

	  def get_message_type(type)
	    types = {"notice" => "success", "error" => "error", "alert" => "error"}
	    types[type]
	  end

	  def default_image_path
	    sprintf("/images/defaults/img%02d.jpg", [*1..8].sample.to_s)
	  end

	  def status_label(status)
	    if status == 'public'
	      return '<span class="ui small teal label">公開中</span>'.html_safe
	    else
	      return '<span class="ui small label">非公開中</span>'.html_safe
	    end
	  end

	end
end