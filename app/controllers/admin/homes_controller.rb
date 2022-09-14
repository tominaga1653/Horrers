class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @posts = Post.order(id: "DESC").page(params[:page]).per(10)
  end
end
