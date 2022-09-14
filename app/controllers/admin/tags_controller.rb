class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.page(params[:page]).per(20)
  end

  def destroy
    Tag.find(params[:id]).destroy
    redirect_to admin_tags_path, notice: "タグを削除しました。"
  end
end
