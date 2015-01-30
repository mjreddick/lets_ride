module API
	class RequestsController < ApplicationController
		protect_from_forgery with: :null_session
    respond_to :json

    def create
    	if logged_in_as(params[:request][:user_id])
        request = Request.new(request_params)
        if request.save
          # create the notification to tell the passenger that the request is pending
  		 		pending_notification = request.notifications.new(user_id: request.user_id)
  		 		pending_notification.set_pending
  		 		pending_notification.save
                  
          # create the notification for the driver for a ride request
          # get the id of the driver for this ride
          driver_id = request.ride.userrides.where(is_driver: true).user_id
  		 		approval_notification = request.notifications.new(user_id: driver_id)
          approval_notification.set_approval
  		 		approval_notification.save

  		   	head 204
    		else
    		  respond_with request
    		end
      end
    end

    def update
      request = Request.find(params[:id])
      driver_id = request.ride.userrides.where(is_driver: true).user_id
      if logged_in_as(driver_id)
        request.notifications.destroy_all
        
        if params[:accepted]
          # rider accepted
          num_riders = request.ride.userrides.where(is_driver: false).count
          
          if num_riders >= request.ride.num_seats
            # ride is already full
            # reject rider
            reject = true;
          else
            # ride not full
            reject = false;
            # create userride
            user_address = request.user_address
            rider_id = request.user_id

            userride = request.ride.userrides.new(user_address: user_address, user_id: user_id, is_driver: false)
            userride.save
          end
        else
          #rider rejected
          reject = true
        end

        # add the correct notification
        notification = request.notifications.new(user_id: request.user_id)
        if reject
          notification.set_rejected
        else
          notification.set_accepted
        end
        notification.save
      end
    end

    private
    	def request_params
    		params.require(:request).permit(:user_address, :ride_id, :user_id)
    	end

  end
end
