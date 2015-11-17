$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sprite/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sprite"
  s.version     = Sprite::VERSION
  s.authors     = ["MP harada"]
  s.email       = ["harada@mediapl.co.jp"]
  s.homepage    = ""
  s.summary     = "Summary of Sprite."
  s.description = "Description of Sprite."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"
	s.add_dependency "mysql2"
	s.add_dependency "nokogiri", "1.6.0"
	s.add_dependency "kaminari"
	s.add_dependency "simple_form"
	s.add_dependency "semantic-ui-sass"
	s.add_dependency "ancestry"
	s.add_dependency "rmagick"
	s.add_dependency "mini_magick"
	s.add_dependency "carrierwave"
	s.add_dependency "jquery-fileupload-rails"
	s.add_dependency "sanitize"
	s.add_dependency "ckeditor"
	s.add_dependency "jquery-rails"
	s.add_dependency "acts-as-taggable-on", "~> 3.4"
	s.add_dependency "acts_as_list"
	s.add_dependency "ransack"
	s.add_dependency "friendly_id", "5.1"
	
	s.add_dependency "pry"
	s.add_dependency "pry-rails"
	s.add_dependency "pry-nav"
	s.add_dependency "better_errors"
	s.add_dependency "binding_of_caller"
	s.add_dependency "better_errors"
	
  s.add_development_dependency "sqlite3"
end
