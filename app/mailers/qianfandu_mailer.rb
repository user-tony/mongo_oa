class QianfanduMailer < ActionMailer::Base
  default from: "admin@qianfandu.com"

  def self.check_and_send(name, *args)
    unless Rails.env == 'test'
      self.send(name, *args).deliver
    end
  end
	
	def notify_daily_emil(daily)
		@daily = daily
		delivery_options = { user_name: "admin@qianfandu.com",
		                     password: 'qianfandu123',
		                     address: "smtp.exmail.qq.com"}
		emails = [ daily.tries(:creator, :employee, :department, :administrator, :email), 'sunbo@qianfandu.com' ]
    mail(to: emails, subject: "#{daily.tries(:creator, :name)} 已提交日报", delivery_method_options: delivery_options )
	end

  def user_sets_password(user)
    @user = useruser
    mail.subject "Set new password"
    mail.to user.email
  end

  def user_resets_password(user)
    @user = user
    mail.subject "Reset password"
    mail.to user.email
  end

  def user_updated_notification(user)
    @user = user
    mail.subject "User updated notification"
    mail.to user.email
  end

  protected

    def check_email
      return if Rails.env == 'test'
    end

end
