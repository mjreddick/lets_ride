require 'rails_helper'

RSpec.describe DashboardsController, :type => :controller do

	describe "Get dashboard" do
    it "responds successfully with an HTTP 200 status code" do
      get :show
      expect(response).to be_success
  
    end
  end

end
