class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  serialize :following, Array
  
  has_many :tweets

  mount_uploader :avatar, AvatarUploader

  def pic
  	if self.avatar.file.nil?
  		return "no_icon.jpg"
  	else
  		return self.avatar.url
  	end
  end

end
