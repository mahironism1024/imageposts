class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @comment = current_user.comments.new(comment_params)
   
    if  @comment.save
      flash[:notice] = "コメントを投稿しました。"
      redirect_to @comment.imagepost
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    
    if current_user == @comment.user
      @comment.destroy
      flash[:notice] = "正常に削除されました。"
      redirect_back(fallback_location: root_url)
    end
  end
  
  private
  
  # def content_param
  #   params.require(:comment).permit(:content)
  # end
  def comment_params
    params.require(:comment).permit(:content, :imagepost_id)
  end
end