class UsersController < ApplicationController
  
  def index
    @users = User.order(id: :desc)
  end
  
  def show
    @user = User.find(params[:id])
    @imageposts = @user.imageposts
  end
  
  def followings
  end
  
  def followers
  end
  
end
