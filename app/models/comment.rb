class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :imagepost, counter_cache: true
  
  validates :content, presence: true, length: { maximum: 100 }
end
