class Request < ActiveRecord::Base
	belongs_to :user
	belongs_to :ride
	has_many :notifications
end
