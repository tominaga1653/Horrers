class Admin::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_root_path
  end

end
