require 'rails_helper'

RSpec.describe Ride, :type => :model do
  it 'should have a valid factory' do 
  	expect(FactoryGirl.build(:user)).to be_valid
  end

	it 'should be invalid without an event' do
		ride = FactoryGirl.build(:ride, event: nil)
	expect(ride).to be_invalid
	end

	it 'should be invalid without num_seats' do
		ride = FactoryGirl.build(:ride, event: nil, num_seats: 0)
		expect(ride).to be_invalid
	end

	
end
