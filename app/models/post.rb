class Post < ApplicationRecord

  belongs_to :user
  has_many   :comments,  dependent: :destroy
  has_many   :post_tags, dependent: :destroy

  validates :category,   presence: true
  validates :tmdb_no,    presence: true
  validates :review,     presence: true

  validates :total_rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0}, presence: true

  validates :story_rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0}, presence: true

  validates :fear_rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0}, presence: true

  validates :splatter_rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0}, presence: true

  enum category: { movie: 0, tv: 1 }

  require 'themoviedb-api'
  Tmdb::Api.key("e535ba068fbc7e54b7f4291825b09afe")
  Tmdb::Api.language("ja")

  def get_tmdb_data
    if self.category == "movie"
      movie = Tmdb::Movie.detail(self.tmdb_no)
      title = movie['title']
      image_url = ( "https://image.tmdb.org/t/p/w342" + movie['poster_path'] )
      data = {title: title, image_url: image_url}
      return data
    else
      tv = Tmdb::TV.detail(self.tmdb_no)
      title = tv['name']
      image_url = ( "https://image.tmdb.org/t/p/w342" + tv['poster_path'] )
      data = {title: title, image_url: image_url}
      return data
    end
  end


end
