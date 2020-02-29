class CreateImageposts < ActiveRecord::Migration[5.2]
  def change
    create_table :imageposts do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
