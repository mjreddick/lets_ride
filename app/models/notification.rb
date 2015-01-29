class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :request

	validates :user, presence: true
	validates :request, presence: true
	validates :type, presence: true, numericality: { only_integer: true, 
		greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }

  
  def set_pending
  	self.type = 2 
  end
	
	def set_accepted
		self.type = 1
	end

	def set_rejected
		self.type = 0
	end

	def set_approval
		self.type = 3
	end

end
