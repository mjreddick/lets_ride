class UsersController < ApplicationController

  def new
    @user = User.new
    @submit_message = 'Sign Up'
  end

  def create
  	@user = User.new(user_params)
		if @user.save
			redirect_to @user, notice: "user saved"
		else
			#redisplay the form that is created. 
			render 'new', alert: "something was wrong"
		end
  end

  def edit
		@submit_message = 'Edit Account'
	end

  private	

  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :image)
  end

end

