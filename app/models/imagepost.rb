class Imagepost < ApplicationRecord
  belongs_to :user
  
  has_many :likes, dependent: :destroy
  has_many :lieks_user, through: :likes, source: :user
  
  has_many :comments, dependent: :destroy
  has_many :comment_user, through: :comments, source: :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
  
  is_impressionable :counter_cache => true, :unique => true
end
