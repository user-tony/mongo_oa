class Manage::ApplicationController < ApplicationController

	layout 'manage/application'
	before_filter :require_login
	before_filter :authorized?
	respond_to :html, :js, :json, :xls, :csv, :tsv

	def index
		render text: '', layout: true
	end

	def not_authenticated
		session[:redirect_back_uri] = request.url
	  redirect_to new_manage_session_path, :alert => "First login to access this page."
	end

	private
	def authorized?
		@current_user = Manage::Account.acquire(@current_user.id) if @current_user
		return true if params[:controller] == 'manage/application' || (@current_user && params[:controller] =~ /\/application/)
		redirect_to '/manage/sessions/new' and return unless @current_user && (editor = @current_user.editor) && editor.active?

		table = params[:controller].gsub('/','_').singularize
		action = {
			'new' => 'create',
			'edit' => 'update',
			'manage_session' => 'show',
		}[params[:action]] || params[:action]
		return @current_user.can?(:index, table) || @current_user.can?(:show, table) if action == 'index'
		@current_user.send("can_#{action}_#{table}?")
	end

	def can? *argv
		@current_user && @current_user.respond_to?(:can?) && @current_user.can?(*argv)
	end

	def model
		name = self.class.name
		return if name =~ /ApplicationController$/

		@model ||= (name =~ /^Manage::(Role|Editor|Grant|Account)/ ? name.remove(/Controller$/) : name.remove(/^Manage|Controller$/)).singularize.safe_constantize
	end

	def param_key
		model.model_name.param_key
	end

	def id
		@id ||= params[:id].try(:to_i)
	end

	def index
		render text: '', layout: true
	end


end
