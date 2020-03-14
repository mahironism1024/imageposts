class User < ApplicationRecord
  
  validates :name, presence: true, length: { maximum: 30 }
  
  has_many :imageposts, dependent: :destroy
  
  has_many :relationships, class_name: "Relationship", foreign_key: "user_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  has_many :likes, dependent: :destroy
  has_many :likes_imagepost, through: :likes, source: :imagepost
  
  def like(imagepost)
    self.likes.find_or_create_by(imagepost_id: imagepost.id)
  end
    
  def unlike(imagepost)
    like = self.likes.find_by(imagepost_id: imagepost.id)
    like.destroy if like
  end
    
  def like?(imagepost)
    self.likes_imagepost.include?(imagepost)
  end
  
  has_many :comments, dependent: :destroy
  has_many :comments_imagepost, through: :comments, source: :imagepost
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable 
         
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = User.dummy_email(auth)
      user.password = Devise.friendly_token[0, 20]
      user.profimage = auth.info.image.gsub("_normal","") if user.provider == "twitter"
      user.profimage = auth.info.image.gsub("picture","picture?type=large") if user.provider == "facebook"
      user.profimage = auth.info.image if user.provider == "google_oauth2"
    end
  end
  
  private
  
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
