class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id,       null: false, foreign_key: true
      t.float   :total_rate,    null: false, default: 0
      t.float   :story_rate,    null: false, default: 0
      t.float   :fear_rate,     null: false, default: 0
      t.float   :splatter_rate, null: false, default: 0
      t.text    :review,        null: false
      t.integer :category,      null: false, default: 0
      t.integer :tmdb_no,       null: false
      t.boolean :is_spoiler,    null: false, default: false

      t.timestamps
    end
  end
end
