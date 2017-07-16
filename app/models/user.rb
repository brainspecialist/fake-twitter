class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  serialize :following, Array
  
  has_many :tweets

  mount_uploader :avatar, AvatarUploader

  def follower_count 
    followers = []
    User.all.each do |user|
      if user.following.include?(self.id)
        followers.push(user)
      end
    end
    followers.count
  end

end
