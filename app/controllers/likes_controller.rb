class LikesController < ApplicationController
before_action :authenticate_user!
  
  def create
    @imagepost = Imagepost.find(params[:imagepost_id])
    current_user.like(@imagepost)
    flash.now[:notice] = "いいね！しました。"
    render 'imageposts/likes_ajax.js.erb'
  end

  def destroy
    @imagepost = Imagepost.find(params[:imagepost_id])
    current_user.unlike(@imagepost)
    flash.now[:notice] = "いいね！を解除しました。"
    render 'imageposts/likes_ajax.js.erb'
  end
end
