class BaseController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => :create
	# caches_action :show, :expires_in => 1.days.to_i, :cache_path => Proc.new { |controller| controller.request.fullpath }
	# caches_action :index, :expires_in => 2.hours, :cache_path => Proc.new { |controller| controller.request.fullpath }

	private

	def not_authenticated   #未授权
		redirect_to new_user_session_path, :alert => "First login to access this page."
	end

end
