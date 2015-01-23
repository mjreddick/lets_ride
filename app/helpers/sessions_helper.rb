module SessionsHelper
	# logs in the given user
	def log_in(user)
		session[:user_id] = user.id.to_s
	end

	# If the current user is logged in then it returns that user
	def current_user
		@current_user ||= User.where(id: session[:user_id]).first
	end

	# Returns true if the user is logged in, false otherwise
	def logged_in?
		!current_user.nil?
	end

	# Check if id is equal to the logged in users id
	def logged_in_as(id)
		id.to_s == session[:user_id]
	end

	# Log out the current user
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end
end
