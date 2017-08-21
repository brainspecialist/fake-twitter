class RemoveFollowingFromUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :following, :string
  end
end
