require 'rails_helper'

RSpec.describe Notification, :type => :model do
  it 'should only allow types 0 through 3' do

  	user = FactoryGirl.create(:user)
  	request = FactoryGirl.create(:request, user: user)

  	notification_high = FactoryGirl.build(:notification, type: 4, user: user, request: request)
  	expect(notification_high).to be_invalid

  	notification_low = FactoryGirl.build(:notification, type: -1, user: user, request: request)
  	expect(notification_low).to be_invalid

  	notification_3 = FactoryGirl.build(:notification, type: 3, user: user, request: request)
  	expect(notification_3).to be_valid

  	notification_0 = FactoryGirl.build(:notification, type: 0, user: user, request: request)
  	expect(notification_0).to be_valid
  end

  it 'should be invalid without a type' do

  	user = FactoryGirl.create(:user)
  	request = FactoryGirl.create(:request, user: user)

  	notification = FactoryGirl.build(:notification, type: nil, user: user, request: request)
  	expect(notification).to be_invalid
  end

  it 'should be invalid if type is not an integer' do
  	user = FactoryGirl.create(:user)
  	request = FactoryGirl.create(:request, user: user)

  	notification = FactoryGirl.build(:notification, type: 1.5, user: user, request: request)
  	expect(notification).to be_invalid
  end

end
