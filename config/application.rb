require File.expand_path('../boot', __FILE__)

require 'rails/all'
 
Bundler.require(*Rails.groups)

module MangoOa
	class Application < Rails::Application
		config.time_zone = 'Beijing'
		config.active_record.default_timezone = :local
		config.active_record.time_zone_aware_attributes = false
		config.encoding = "utf-8"
		config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
		config.i18n.available_locales = %w[en zh-CN zh-TW zh-HK ja ko fr de es it]
		config.i18n.default_locale = 'zh-CN'
		config.active_support.escape_html_entities_in_json = true
		config.generators{|g| g.orm :active_record}
		
		::RAILS_ROOT = Rails.root
		::RAILS_ENV = Rails.env
 
	end
end
 