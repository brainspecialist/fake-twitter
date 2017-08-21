class Follow < ApplicationRecord
	# The user in user_id is following the user in following_id
	belongs_to :user, :foreign_key => "user_id", :class_name => "User", counter_cache: :follow_count
	belongs_to :following, :foreign_key => "following_id", :class_name => "User", counter_cache: :followers
end
