class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @user = User.find(params[:id])
    @imageposts = @user.imageposts
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(profile_params)
      flash.now[:notice] = "プロフィールを更新しました。"
      render :update
    else
      flash.now[:alert] = "プロフィール更新に失敗しました。"
      render :update
    end
  end
  
  def followings
  end
  
  def followers
  end
  
  private
  
  def profile_params
    params.require(:user).permit(:name, :selfintroduction)
  end
  
end
