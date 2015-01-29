class Request < ActiveRecord::Base
	belongs_to :user
	belongs_to :ride
	has_many :notifications

	validates :user, presence: true
	validates :ride, presence: true
end
