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
      respond_to do 
        format.js { flash.now[:alert] = "プロフィール更新に失敗しました。" }
      end
      render :update
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end
  
  private
  
  def profile_params
    params.require(:user).permit(:name, :selfintroduction)
  end
  
end
