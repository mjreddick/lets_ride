require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do

  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end

    it "renders the static home page" do
      get :home
      expect(response).to render_template("home")
    end
  
  end

end
