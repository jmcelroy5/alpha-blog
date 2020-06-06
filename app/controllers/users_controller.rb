class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to Alpha Blog, #{@user.name}! You have successfully signed up."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account info was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def index
    @users = User.all
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end