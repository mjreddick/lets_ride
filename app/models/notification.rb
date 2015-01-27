class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :request

	validates :type, presence: true, numericality: { only_integer: true, 
		greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }
end
