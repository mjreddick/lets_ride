class UsersController < ApplicationController

  def new
    @user = User.new
    @submit_message = 'Sign Up'
  end
  
end

