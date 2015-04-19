class Manage::SessionsController < Manage::ApplicationController

	layout 'manage/sessions/application'
	skip_before_filter :require_login
	skip_before_filter :authorized?

	def index
		redirect_to '/'
	end

	def new
		@user = Manage::Account.new
	end

	def create
		user = login(user_params[:name], user_params[:password], user_params[:remember_me])
		if user
			if Manage::Account.find(user.id).active
				if Manage::Editor.where(id: user.id).first
					redirect_to session[:redirect_back_uri] and return if session[:redirect_back_uri]
					redirect_to manage_root_url, notice: '操作成功' and return
				else
					flash.now.notice = "抱歉,您没有后台权限"
				end
			else
				flash.now.notice = "该用户已被锁定，请更新其它账号"
			end
		else
			flash.now.notice = "用户名或密码错误！"
		end
		@user = Manage::Account.new
		render :new
	end

	def destroy
		logout
		redirect_to root_url, notice: "操作成功"
	end

	def user_params
		params.require(:manage_account).permit(:name, :password, :remember_me)
	end

end
