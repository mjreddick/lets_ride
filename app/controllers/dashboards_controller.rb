class DashboardsController < ApplicationController
	before_action :require_correct_user, only: [:show]
	def show
		@notifications = current_user.notifications
		@rides = current_user.rides

	end
	
	private
		def require_correct_user
			unless logged_in_as(params[:id])
				flash[:danger] = "You must be logged in to complete that action"
				redirect_to :login and return
			end
		end

end
