require 'rails_helper'

RSpec.describe User, :type => :model do

  # Here is what is tested on a model
  
  # 1. Validations
  # 2. Logic
  # 3. Scopes
  it 'has a valid factory' do
		expect(FactoryGirl.build(:user)).to be_valid
	end

	it 'is invalid without a first name' do 
		user = FactoryGirl.build(:user, first_name: nil)
		expect(user).to be_invalid
	end

	it 'is invalid without a last name' do
		user = FactoryGirl.build(:user, last_name: nil)
		expect(user).to be_invalid
	end

	it 'returns a users full name as a string' do 
		user = FactoryGirl.build(:user)
		expect(user.fullname).to eq("Firstname Lastname")
	end

	it 'is invalid without an email address' do 
		user = FactoryGirl.build(:user, email: nil)
		expect(user).to be_invalid
	end

	it {expect(subject).to respond_to(:password_digest)}

	it {expect(subject).to respond_to(:authenticate)}

end
