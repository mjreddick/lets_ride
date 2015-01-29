module API
	class RequestsController < ApplicationController
		protect_from_forgery with: :null_session
    respond_to :json

    def create
    	if logged_in_as(params[:request][:user_id])
    		 request = Request.new(request_params)
    		 if request.save
            # create the notification to tell the passenger that the request is pending
    		 		pending_notification = request.notifications.new(user_id: params[:request][:user_id])
    		 		pending_notification.set_pending
    		 		pending_notification.save
                    
            # create the notification for the driver for a ride request
            # get the id of the driver for this ride
            driver_id = request.ride.userrides.where(is_driver: true).user_id
    		 		approval_notification = request.notifications.new(user_id: driver_id)
            approval_notification.set_approval
    		 		approval_notification.save

    		   	respond_with request, location: [:api, request]
    		 else
    		 	 	respond_with request
    		 end
    	end
    end

    def show
    	request = Request.find(params[:id])
    	respond_with request
    end

    private
    	def request_params
    		params.require(:request).permit(:user_address, :ride_id, :user_id)
    	end

  end
end

  create_table "notifications", force: true do |t|
    t.integer  "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "request_id"
  end