class Public::HomesController < ApplicationController

  def top
    @posts = Post.order(id: "DESC").page(params[:page]).per(10)
  end

  def about
  end

end
