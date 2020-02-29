class LikesController < ApplicationController
before_action :authenticate_user!
  
  def create
    imagepost = Imagepost.find(params[:imagepost_id])
    current_user.like(imagepost)
    flash[:notice] = "いいね！しました"
    redirect_back(fallback_location: root_url)
  end

  def destroy
    imagepost = Imagepost.find(params[:imagepost_id])
    current_user.unlike(imagepost)
    flash[:notice] = "いいね！を取り消しました"
    redirect_back(fallback_location: root_url)
  end
end
