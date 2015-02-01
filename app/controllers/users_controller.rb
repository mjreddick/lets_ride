class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :edit, :update]

  def new
    @user = User.new
    @submit_message = 'Sign Up'
  end

  def create
  	@user = User.new(user_params)
		if @user.save
      log_in @user
			redirect_to @user, notice: "user saved"
		else
			#redisplay the form that is created. 
			render 'new', alert: "something was wrong"
		end
  end

  def edit
		@submit_message = 'Update Account'
	end

	def show
	end

  def update
    @user.update_attributes(user_params)
    if @user.save
      redirect_to @user
    else
      render 'edit'
    end
  end

  private	

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
    	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
    end

end

