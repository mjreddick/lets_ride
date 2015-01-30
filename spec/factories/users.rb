FactoryGirl.define do
  factory :user do
    email "something@test.com"
		first_name "Firstname"
		last_name "Lastname"
		password_digest BCrypt::Password.create("password")
  end

end
