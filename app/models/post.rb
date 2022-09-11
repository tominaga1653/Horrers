class Post < ApplicationRecord

  belongs_to :user
  has_many   :comments,  dependent: :destroy
  has_many   :post_tags, dependent: :destroy
  has_many   :tags,      through:   :post_tags

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

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    # 不要なポストタグを消す
    old_tags.each do |old|
      tag = Tag.find_by(name: old)
      post_tag = PostTag.find_by(post_id: self.id, tag_id: tag.id)
      post_tag.destroy
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      PostTag.create({post_id: self.id, tag_id: new_post_tag.id})
    end
 end


end
