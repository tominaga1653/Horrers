class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page]).per(20)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "変更内容が保存されました。"
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:image, :name, :introduction, :is_stopped)
    end
end
