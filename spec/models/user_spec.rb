require 'rails_helper'

RSpec.describe User, :type => :model do

	# respond to an email
	it {expect(subject).to respond_to(:email)}

	# respond to a first_name
	it {expect(subject).to respond_to(:first_name)}

	# respond to a last_name
	it {expect(subject).to respond_to(:last_name)}

	# respond to a password_digest
	it {expect(subject).to respond_to(:password_digest)}

	# respond to authenticate
	it {expect(subject).to respond_to(:authenticate)}

end
