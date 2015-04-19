class User::SessionsController < User::ApplicationController
	layout 'manage/sessions/application'
	before_action :user_params, only: %w[create]

	def index
		respond_to do |format|
			format.html { redirect_to params[:redirect] || root_path }
			@data = {
				'session_key' => (session.inspect;request.session_options[:id]),
				'secret' => (session[:secret] || (session[:secret] = form_authenticity_token) ),
				'current_time' => Time.now.to_s(:db),
				'current_user' => (@current_user && @current_user.id),
				'is_cookie_supported' => !!cookies[request.session_options[:key]],
			}
			format.xml { render xml: @data }
			format.json { render json: @data }
		end
	end

	def show
		# render xml: @current_user
	end

	def new
		@user = User.new
	end

	def create
		user = login(user_params[:name], user_params[:password], user_params[:remember_me])
		if user
			if user.active
				redirect_back_or_to root_url, :notice => "操作成功"
			else
				flash[:notice] = '该用户已停用，请联系管理员'
				redirect_to root_url
			end
		else
			flash.now[:errors] = "账号或密码错误"
			@user = User.new
			render :new
		end
	end

	def destroy
		logout
		redirect_to root_url, :notice => "Logged out!"
	end

	def user_params
		params.require(:user).permit(:name :password, :remember_me)
	end
end
