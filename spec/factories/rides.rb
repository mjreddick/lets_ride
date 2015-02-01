FactoryGirl.define do
  factory :ride do
    num_seats 4
    event
  end

  factory :ride_with_users, parent: :ride do |ride|
  	userrides { build_list :userride, 5}
  end
end
