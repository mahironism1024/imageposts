class AddImpressionsCountToImagepost < ActiveRecord::Migration[5.2]
  def change
    add_column :imageposts, :impressions_count, :int, null: false, default: 0
  end
end
