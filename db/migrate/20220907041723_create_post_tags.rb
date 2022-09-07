class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.integer :post_id, null: false, foreign_key: true
      t.integer :tag_id,  null: false, foreign_key: true

      t.timestamps
    end
  end
end
