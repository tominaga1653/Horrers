class Admin::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page]).per(20)
  end

  def edit
  end

  def update
  end

end
