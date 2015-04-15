Kaminari.configure do |config|
	config.default_per_page = 25
	config.max_per_page = nil
	config.window = 2
	config.outer_window = 4
	config.left = 5
	config.right = 3
	config.page_method_name = :page
	config.param_name = :page
end
