class AddLikesCountAndCommentsCountToImagepost < ActiveRecord::Migration[5.2]
  def change
    add_column :imageposts, :likes_count, :integer, null: false, default: 0
    add_column :imageposts, :comments_count, :integer, null: false, default: 0
  end
end
