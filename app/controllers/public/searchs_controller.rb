class Public::SearchsController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key("e535ba068fbc7e54b7f4291825b09afe")
  Tmdb::Api.language("ja")
  
  def search
  end

  def detail
  end
  
end
