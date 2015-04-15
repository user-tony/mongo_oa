class Manage::UsersController < Manage::PatternsController

	def password
		@user = model.f(id)
	end

	def update_password
		@user = User.f(id)
		@user.attributes = params.require(:user).permit(:password_confirmation, :password)
		if @user.password == @user.password_confirmation
			@user.change_password!(@user.password)
		end
		render :password
	end


end
