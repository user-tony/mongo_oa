class Manage::Log < ActiveRecord::Base
	
	CONTROLLERS = %w[
		
	]
	
	ACTIONS = %w[
	
	]
	
	enum controller: CONTROLLERS.map { |controller| "_controller_#{controller}" }, action: ACTIONS.map { |action| "_action_#{action}" }
	
end
