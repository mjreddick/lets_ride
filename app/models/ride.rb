class Ride < ActiveRecord::Base
	belongs_to :event
	has_many :userrides
	has_many :users, through: :userrides
end
