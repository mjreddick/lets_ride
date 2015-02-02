require 'rails_helper'

RSpec.describe Userride, :type => :model do
    it 'has a valid factory' do
		expect(FactoryGirl.build(:userride)).to be_valid
	end
end
