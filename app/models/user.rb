class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  serialize :following, Array
  
  has_many :tweets

  has_many :follows, :foreign_key => "user_id", :class_name => "Follow"

  has_many :followings, :through => :follows

  mount_uploader :avatar, AvatarUploader

end
