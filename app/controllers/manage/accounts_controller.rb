class Manage::AccountsController < Manage::PatternsController



	# def create
	# 	record = model.new
	# 	compose_param = params.require(param_key).permit(*record.manage_fields)
	# 	ext_options = { updater_id: @current_user.id, active: true }
	# 	ext_options = ext_options.merge(creator_id: @current_user.id) if model.attribute_names.include?('creator_id')
	# 	record.update compose_param.to_h.slice(*model.manage_fields).merge ext_options
	# 	instance_variable_set "@#{controller_name.singularize}".to_sym, record
	# 	render :show
	# end


end
