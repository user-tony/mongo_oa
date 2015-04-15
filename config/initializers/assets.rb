	# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added..
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w{
	html5shiv.js
	modernizr.min.js
	css/bootstrap.min.css
	css/demo.min.css
	css/font-awesome.min.css
	css/invoice.min.css
	css/lockscreen.min.css
	css/smartadmin-production.min.css
	css/smartadmin-rtl.min.css
	css/smartadmin-skins.min.css
	css/your_style.css
}
