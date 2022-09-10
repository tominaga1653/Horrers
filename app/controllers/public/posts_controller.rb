class Public::PostsController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key("e535ba068fbc7e54b7f4291825b09afe")
  Tmdb::Api.language("ja")

  def new
    @category = params[:category]
    @tmdb_no = params[:tmdb_no]
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿が完了しました。"
    else
      @category = @post.category
      @tmdb_no = @post.tmdb_no
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "編集が完了しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to my_page_path, notice: "投稿を削除しました。"
  end


  private

  def post_params
    params.require(:post).permit(:category, :tmdb_no, :total_rate, :story_rate, :fear_rate, :splatter_rate, :review, :is_spoiler)
  end

end
