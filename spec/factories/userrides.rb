FactoryGirl.define do
  factory :userride do
    # zipcode {Faker::Address.zip_code}
    zipcode "90210"
		is_driver false
		user
		ride
  end

end
