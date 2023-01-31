class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
  # user = User.new(user_params)
  # if user.save
  #   session[:user_id] = user.id
  #   redirect_to '/'
  # else
  #   redirect_to '/signup'
  # end

  user_params[:email].downcase!
  @user = User.new(user_params)
  
    if @user = User.authenticate_with_credentials(params[:email], params[:password])
      # success logic, log them in
      session[:user_id] = @user.id
      redirect_to '/'
    else
      # failure, render login form
      redirect_to '/login'
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end