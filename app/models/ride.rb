class Ride < ActiveRecord::Base
	validates :event, presence: true
	validates :num_seats, presence: true
	belongs_to :event
	has_many :userrides
	has_many :users, through: :userrides
end
