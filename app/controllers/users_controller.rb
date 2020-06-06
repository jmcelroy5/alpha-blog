class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to Alpha Blog, #{@user.name}! You have successfully signed up."
      redirect_to articles_path
      # renders user#show
      # redirect_to @article
    else
      render 'new'
    end
  end

  def show
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end