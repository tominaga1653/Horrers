class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:post_list]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = current_user
    @posts = @user.posts.order(id: "DESC").page(params[:page]).per(10)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_page_path, notice: "変更内容が保存されました。"
    else
      render :edit
    end
  end

  def post_list
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: "DESC").page(params[:page]).per(10)
  end

  private
    def user_params
      params.require(:user).permit(:image, :name, :introduction)
    end

    def ensure_guest_user
      @user = current_user
      if @user.email == "guest@example.com"
        redirect_to my_page_path, notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end
end
