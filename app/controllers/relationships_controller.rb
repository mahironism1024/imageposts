class RelationshipsController < ApplicationController
  before_action :user_signed_in?
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:notice] = "#{user.name}をフォローしました。"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:alert] = "#{user.name}のフォローを解除しました。"
    redirect_back(fallback_location: root_path)
  end
end
