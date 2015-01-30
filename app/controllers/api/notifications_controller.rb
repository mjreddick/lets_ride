module Api
	class NotificationsController < ApplicationController
		protect_from_forgery with: :null_session
    respond_to :json

    	
    def destroy
    	notification = Notification.find(params[:id])
    	if logged_in_as(notification.user_id)
	    	notification.destroy
	    	head 204
	    else
	    	head 401
	    end
    end

  end
end