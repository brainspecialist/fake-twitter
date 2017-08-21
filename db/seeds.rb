# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include TweetsHelper

User.destroy_all
Tweet.destroy_all
Follow.destroy_all

5.times do
	user = User.create(
		name: Faker::Simpsons.character,
		username: Faker::Twitter.screen_name,
		bio: Faker::Simpsons.quote,
		location: Faker::Simpsons.location,
		password: Faker::Internet.password,
		email: Faker::Internet.email,
	)
	5.times do
		tweet = user.tweets.create(
			message: Faker::HitchhikersGuideToTheGalaxy.quote + ' #' + Faker::HitchhikersGuideToTheGalaxy.planet,
		)
		tweet = get_tagged(tweet)
	end
end

array = User.pluck(:id)
combos = array.permutation(2).to_a.sample(10)
combos.each do |combo|
	follower = Follow.create(
		user_id: combo[0],
		following_id: combo[1],
		)
end