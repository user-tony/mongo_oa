class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	rescue_from ActiveRecord::RecordInvalid, with: :render_404
	rescue_from ActiveRecord::RecordNotFound, with: :render_404



	def index
		render text: ''
	end

	def database_transaction
		begin
			ActiveRecord::Base.transaction do
				yield
			end
			true
		rescue => e
			logger.error %[#{e.class.to_s} (#{e.message}):\n\n #{e.backtrace.join("\n")}\n\n]
			false
		end
	end

	def render_404
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end



end
