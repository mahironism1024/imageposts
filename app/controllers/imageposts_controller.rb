class ImagepostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create]
  before_action :user_check, only: [:edit, :update, :destroy]
  impressionist :actions=>[:show], :unique => [:impressionable_id, :ip_address]
  
  def index
    @imageposts = Imagepost.order(id: :desc).page(params[:page]).per(15)
  end

  def show
    @imagepost = Imagepost.find_by(id: params[:id])
    @user = User.find_by(id: @imagepost.user_id)
    
    if @imagepost
      @views = @imagepost.impressions.size
      @comment = Comment.new(imagepost_id: @imagepost.id)
      @comments = Comment.where(imagepost_id: @imagepost.id)
    else
      flash[:alert] = "画像が見つかりませんでした。"
      redirect_to root_url
    end
  end

  def new
    @imagepost = current_user.imageposts.new
  end

  def create
    @imagepost = current_user.imageposts.new(image_params)
    
    if @imagepost.save
      flash[:notice] = "画像を新規投稿しました。"
      redirect_to imagepost_url(@imagepost)
    else
      flash.now[:alert] = "画像の投稿に失敗しました。"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @imagepost.update(image_params)
      flash[:notice] = "更新が完了しました"
      redirect_to @imagepost
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @imagepost.destroy
    
    flash[:notice] = "正常に削除されました。"
    redirect_to imageposts_url
  end
  
  def like_ranking
    @like_ranking = Imagepost.find(Like.group(:imagepost_id).order('count(imagepost_id) desc').limit(3).pluck(:imagepost_id))
  end
  
  def pv_ranking
    @pv_ranking = Imagepost.find(Impression.group(:impressionable_id).order('count(impressionable_id) desc').limit(3).pluck(:impressionable_id))
  end
  
  private
  
  def image_params
    params.require(:imagepost).permit(:title, :description, :image)
  end
  
  def update_params
    params.require(:imagepost).permit(:title, :description)
  end
  
  def user_check
    @imagepost = Imagepost.find(params[:id])
    
    unless current_user == @imagepost.user
      redirect_to @imagepost
    end
  end
  
end
