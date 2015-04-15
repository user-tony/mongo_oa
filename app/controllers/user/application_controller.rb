class User::ApplicationController < BaseController
	
	layout 'manage/sessions/application'
	respond_to :html, :js, :json, :xml
	
end
