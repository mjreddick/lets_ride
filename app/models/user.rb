class User < ActiveRecord::Base
	has_many :userrides
	has_many :rides, through: :userrides

	mount_uploader :avatar, AvatarUploader, mount_on: :avatar
	attr_accessor :password, :mount_uploader



	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, presence: true, uniqueness: {case_sensitive: false},
		length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :password, presence: true, length: {in: 5..50}, confirmation: true,
		unless: "self.password_digest.present? && self.password.blank?"

	before_save do
		self.first_name.capitalize!
		self.last_name.capitalize!
		self.email = email.downcase
		hash_password(self.password)
	end

	def fullname
		"#{first_name} #{last_name}"
	end

	def authenticate(password_attempt)
		# if password_attempt hashes to password_digest then return the user
		# otherwise return false
		BCrypt::Password.new(self.password_digest).is_password?(password_attempt) && self
	end

  private

    def hash_password(new_password)
      self.password_digest = BCrypt::Password.create(new_password) unless new_password.blank?
    end

end
