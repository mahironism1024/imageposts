class Like < ApplicationRecord
  belongs_to :user
  belongs_to :imagepost, counter_cache: true
end
