class Public::SearchsController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key("e535ba068fbc7e54b7f4291825b09afe")
  Tmdb::Api.language("ja")

  def search
    # binding.pry
    # pp Tmdb::Search.movie("Harry")
    @category = params[:category]
    @content = params[:content]
    if @category == "movie"
      @movies = Tmdb::Search.movie(@content)
    elsif @category == "tv"
      @tvs = Tmdb::Search.tv(@content)
    else #カテゴリーがタグの場合
      tag = Tag.find_by(name: @content)
      if tag != nil
        @posts = tag.posts.order(id: "DESC").page(params[:page]).per(10)
        render :tag_posts_list
      else
        redirect_to root_path, notice: "入力されたタグは見つかりませんでした。"
      end
    end
  end

  def detail
    @category = params[:category]
    @tmdb_no = params[:tmdb_no]
    @posts = Post.where(category: @category, tmdb_no: @tmdb_no)
    if @category == "movie"
      @movie = Tmdb::Movie.detail(@tmdb_no)
    else
      @tv = Tmdb::TV.detail(@tmdb_no)
    end
  end

  def tag_posts_list
    tag = Tag.find(params[:id])
    @posts = tag.posts.order(id: "DESC").page(params[:page]).per(10)
  end

  def post_rate_search
    @posts = Post.where(category: params[:post_category])
    @posts = @posts.rate_sort(params[:rate], params[:high_low]).page(params[:page]).per(10)
    render :tag_posts_list
  end

end
