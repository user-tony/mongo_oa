class User::RegistrationsController < User::ApplicationController
	layout 'manage/sessions/application'
	before_action :user_params, only: %w[create]
	
	def new
		@user = User.new
	end
	
	def create
		success = database_transaction do
			@user = User.new(user_params)
			@user.save!
			@account = Manage::Account.new(@user.attributes.slice(*%w{id gender name birthday }))
			@account.save!
		end
		
	  if success
	    redirect_to root_url, success: "成功登陆!"
	  else
			flash.now[:errors] = '操作错误'
			render :new
	  end
	end
	
	
	def user_params
	  params.require(:user).permit(:email, :name, :password, :password_confirmation, :gender, :birthday)
	end
	
	
end
