class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :request

	validates :user, presence: true
	validates :request, presence: true
	validates :category, presence: true, numericality: { only_integer: true, 
		greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }

  NOTIFICATION_CATEGORIES = { 0 => "rejected", 1 => "accepted", 2 => "pending", 3 => "approval"};
  
  def set_pending
  	self.category = 2 
  end
	
	def set_accepted
		self.category = 1
	end

	def set_rejected
		self.category = 0
	end

	def set_approval
		self.category = 3
	end

	def get_category
		NOTIFICATION_CATEGORIES[self.category]
	end

end
