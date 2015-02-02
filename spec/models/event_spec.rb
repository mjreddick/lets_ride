require 'rails_helper'

RSpec.describe Event, :type => :model do
    it 'should have a valid factory' do 
  	expect(FactoryGirl.build(:event)).to be_valid
  end

end
