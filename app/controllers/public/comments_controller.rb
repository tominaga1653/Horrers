class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    @comment = Comment.new
    flash.now[:notice] = "コメントを投稿しました。"
  end

  def destroy
    Comment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    flash.now[:notice] = "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def ensure_correct_user
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      redirect_to root_path
    end
  end

end
