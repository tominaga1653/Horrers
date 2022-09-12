class Admin::CommentsController < ApplicationController

  def index
    @comments = Comment.order(id: "DESC").page(params[:page]).per(20)
  end

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    comment.destroy
    redirect_to admin_post_path(post), notice: "コメントを削除しました。"
  end

end
