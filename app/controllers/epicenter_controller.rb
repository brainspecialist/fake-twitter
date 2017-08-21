class EpicenterController < ApplicationController
  before_action :authenticate_user!
  before_action :set_following, only: [:feed, :all_users, :show_user]

  def feed
  	@following_tweets = []
    @tweet = Tweet.new

    Tweet.all.order(created_at: :desc).each do |tweet|
      if @following.include?(tweet.user_id) || current_user.id == tweet.user_id
        @following_tweets.push(tweet)
      end
    end
  end

  def all_users
    @users = User.order(:username)
  end

  def show_user
  	@user = User.find(params[:id])
  end

  def now_following
  	# Add the ID of the user to follow and current user's ID to Follow table
  	Follow.create(user_id: current_user.id, following_id: params[:id].to_i)

  	redirect_to show_user_path(id: params[:id])
  end

  def unfollow
  	@followship = Follow.where("user_id = ? AND following_id =?", current_user.id, params[:id].to_i).take
    @followship.destroy

  	redirect_to show_user_path(id: params[:id])
  end

  def following
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if @user.following.include?(user.id)
        @users.push(user)
      end
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end
  
  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  private

  def set_following
    @following = Follow.where(user_id: current_user.id).pluck(:following_id)
  end
  
end
