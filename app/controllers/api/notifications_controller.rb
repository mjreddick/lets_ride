module API
	class NotificationsController < ApplicationController
		protect_from_forgery with: :null_session
    respond_to :json

    def destroy
    	notification = Notification.find(params[:id])
    	notification.destroy
    	head 204
    end

  end
end