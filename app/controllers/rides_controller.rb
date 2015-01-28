class RidesController < ApplicationController
	
	def index
		@rides = Ride.all
	end

	def show
	end

end
