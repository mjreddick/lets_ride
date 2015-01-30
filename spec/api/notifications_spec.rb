require "rails_helper"

include SessionsHelper

describe "Notifications API", :type => :request do
	#create a variable request_headers
	let(:request_headers) { { "Accept" => "application/json", "Content-type" => "application/json" } }

  it "returns 401 if the user is not the owner of the notification and logged in" do
    # set up the notification
    user = FactoryGirl.create(:user)
    request = FactoryGirl.create(:request, user: user)
    notification = FactoryGirl.create(:notification, request: request, user: user)
    notification.set_pending
    notification.save!
    
    # check everything is valid
    expect(user).to be_valid
    expect(request).to be_valid
    expect(notification).to be_valid
    
    # send delete request
    delete "/api/notifications/#{notification.id}", request_headers
    # check status code
    expect(response).to have_http_status 401
    # make sure the notification is still in the database
    expect(Notification.where(id: notification.id)).to exist
  end

  it "deletes a notification if the request is sent by the owning user" do
    # set up the notification
    user = FactoryGirl.create(:user)
    request = FactoryGirl.create(:request, user: user)
    notification = FactoryGirl.create(:notification, request: request, user: user)
    notification.set_pending
    notification.save
    
    # check everything is valid
    expect(user).to be_valid
    expect(request).to be_valid
    expect(notification).to be_valid

    # log in
    post '/login', { :session => {:email => user.email, :password => "password"} }

    # send delete request
    delete "/api/notifications/#{notification.id}", request_headers
    # check status code
    expect(response).to have_http_status 204
    # make sure it was removed from the database
    expect(Notification.where(id: notification.id)).not_to exist
  
  end

end