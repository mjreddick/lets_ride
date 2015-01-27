require 'rails_helper'

RSpec.describe Ride, :type => :model do
  it 'should have a valid factory' do 
  	expect(FactoryGirl.build(:user)).to be_valid
  end

  
end
