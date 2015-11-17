require "nokogiri"
require "kaminari"
require "simple_form"
require "semantic-ui-sass"
require 'friendly_id'
require "ancestry"
require "rmagick"
require "mini_magick"
require "carrierwave"
require "jquery-fileupload-rails"
require "sanitize"
require "ckeditor"
require "jquery-rails"
require "acts-as-taggable-on"
require "acts_as_list"
require "ransack"
require "better_errors"
require "pry"


module Sprite
  class Engine < ::Rails::Engine
    isolate_namespace Sprite
		
		paths["config/initializers"] # => ["config/initializers"]
	  paths["config/locales"]      # => ["config/locales"]
		
    #自分のローカル時間を記録
    config.time_zone = 'Tokyo'

    #Active Record Timezone
    config.active_record.default_timezone = :local
		
		config.autoload_paths += %W(#{config.root}/app/models/sprite/module)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

		config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Sprite::Engine.root.join('public', 'locales', '*.{rb,yml}').to_s]
    I18n.enforce_available_locales = true
    
		
  end
end
