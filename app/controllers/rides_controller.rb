class RidesController < ApplicationController

	def index
		if logged_in?
			# do all this stuff
			zipcode = params[:zipcode]
			eventful_id = params[:eventful_id]
			event = Event.find_by eventful_id: eventful_id
			@rides = Ride.joins(:event, :userrides).where(event: event, userrides: { zipcode: zipcode, is_driver: true} )
			@users = User.joins(:userrides, :rides).where(userrides: {is_driver: true, zipcode: zipcode}, rides: {event: event}).distinct
		else
			redirect_to login_path
		end
	end

	def new
		@ride = Ride.new
	end

	def show
		@ride = Ride.find(params[:id])
	end

	def create
		# check if the user is logged in
		if logged_in?
			# see if the event already exists
			@event = Event.where(eventful_id: params[:event][:eventful_id]).first

			# if not create it
			@event = Event.create(event_params) unless @event

			if @event
				#Event exists, or was created, now create the ride
				if @ride = @event.rides.create(ride_params)
					#ride saved successfully
					#Create the driver's userride
					@userride = @ride.userrides.new(zipcode: params[:ride][:zipcode], is_driver: true, user: current_user)

					if @userride.save
						#Everything needed is now in the database

					else
						# error creating userride, show error message
						flash[:danger] = "An error occurred while saving data associated with your ride, please try again"
					end

				else
					# error creating ride, show error message
					flash[:danger] = "An error occurred while saving your ride, please try again"
				end

			else
				# error creating event, show error message
				flash[:danger] = "An error occurred while saving the event associated with your ride, please try again"
			end

			# redirect the user to their dashboard
			redirect_to dashboard_path(current_user)

		else
			# if not logged in redirect them to the login page
			flash[:danger] = "Must be logged in to create a ride"
			redirect_to login_path
		end

	end



	def edit
		@ride = Ride.find(params[:id])
	end

	def update
		@ride = Ride.find(params[:id])
		if @ride.update_attributes(ride_params)
			redirect_to rides_path, alert: "Ride Updated"
		else
			render "edit"
		end
	end

	def destroy
		@ride = Ride.find(params[:id])
    @ride.destroy
    session.delete(:ride_id)
    redirect_to root_path
	end

	private
	def ride_params
		params.require(:ride).permit(:num_seats)
	end

	def event_params
		params.require(:event)
					.permit(:eventful_id, :image_url_medium, :image_url_large, 
									:title, :details, :start_date_time, :venue_name)
	end

end
