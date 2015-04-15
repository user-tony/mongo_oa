class Manage::PatternsController < Manage::ApplicationController

	def index
		render text: '', layout: true and return if controller_name.match(/application/)
		records = model.default(params).includes(model.send(:reflections).keys)
		# records = records.city_id(city.id) if model.attribute_names.include?('city_id')
		records = records.none if !can?(:index, model) && records.count > 1
		instance_variable_set "@#{controller_name}", records
	end

	def show
		instance_variable_set "@#{controller_name.singularize}".to_sym, model.f(id)
	end

	def preview
		instance_variable_set "@#{controller_name.singularize}".to_sym, model.f(id)
	end

	def new
		record = model.new
		record.attributes = model.f(id).attributes.slice(*record.manage_fields) if id
		instance_variable_set "@#{controller_name.singularize}".to_sym, record
		render :show
	end

	def create
		record = model.new
		compose_param = params.require(param_key).permit(*record.manage_fields)
		ext_options = { updater_id: @current_user.id, active: true }
		ext_options = ext_options.merge(creator_id: @current_user.id) if model.attribute_names.include?('creator_id')
		# ext_options = ext_options.merge(city_id: city.id) if model.attribute_names.include?('city_id')
		record.update compose_param.to_h.slice(*model.manage_fields).merge ext_options
		instance_variable_set "@#{controller_name.singularize}".to_sym, record
		render :show
	end

	def edit
		instance_variable_set "@#{controller_name.singularize}".to_sym, model.f(id)
		render :show
	end

	def update
		record = model.f(id)
		compose_param = params.require(param_key).permit(*record.manage_fields)
		ext_options = { updater_id: @current_user.id, active: true }
		ext_options = ext_options.merge(creator_id: @current_user.id) if model.attribute_names.include?('creator_id')
		ext_options = ext_options.merge(city_id: city.id) if model.attribute_names.include?('city_id')
		record.update compose_param.to_h.slice(*model.manage_fields).merge ext_options
		instance_variable_set "@#{controller_name.singularize}".to_sym, record
		render :show
	end

	def publish
		record = model.f(id)
		record.update_attributes(published: true, updater_id: @current_user.id)
		head record.valid? ? :accepted : :bad_request
	end

	def unpublish
		record = model.f(id)
		record.update_attributes(published: false, updater_id: @current_user.id)
		head record.valid? ? :accepted : :bad_reqest
	end

	def delete
		instance_variable_set "@#{controller_name.singularize}".to_sym, model.f(id)
		render template: 'manage/shared/delete'
	end

	def destroy
		record = model.f id
		record.update active: false, updater_id: @current_user.id
		instance_variable_set "@#{controller_name.singularize}".to_sym, record
		render :show
	end

end
