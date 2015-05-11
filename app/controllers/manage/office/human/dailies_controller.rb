class Manage::Office::Human::DailiesController < Manage::Office::Human::ApplicationController
	def index
		render text: '', layout: true and return if controller_name.match(/application/)
		records = model.default(params).includes(model.send(:reflections).keys)
		if @current_user.administrations.present?
			ids = [ @current_user.id, @current_user.administrator_childs.map{ |a| a.employees.pluck(:id) } ]
			records = records.where(creator_id: ids.flatten)
		end
		records = records.none if !can?(:index, model) && records.count > 1
		instance_variable_set "@#{controller_name}", records
	end
end
