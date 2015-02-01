class RidesController < ApplicationController

	def index
		@rides = Ride.all
		@users = User.all

		# if logged_in?
		# 	render
		# else
		# 	redirect_to new_user_path

	end

	def new
		@ride = Ride.new
	end

	def show
		@ride = Ride.find(params[:id])
	end

	def create
		event = Event.find(params[:event_id])
		new_ride = ride_params
		ride = event.rides.create[new_ride]
		if @ride.save
			redirect_to ride_path
		else
			render new
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
		params.require(:ride).permit(:event, :num_seats, :id)
	end

end
