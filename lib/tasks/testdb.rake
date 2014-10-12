require 'database_cleaner'

namespace :dbtest do
  desc "Fill database with sample data"
  task populate: :environment do
    puts "cleaning DB"
    clean_data

    puts "creating users"
    update_users

    puts "creating topics"
    update_topic

    puts "creating sub topics"
    update_sub_topic

    puts "creating comments"
    update_comments

    puts "done"
  end
end

def clean_data
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
end

def update_users
	names = []
	5.times do 
		names.push(Faker::Name.first_name)
	end
	names.push('shahaf','itay')

	names.each do |name|
		user = User.create({
			:mail => name + '@ftbpro.com',
			})
	end
end

def update_topic
	users = User.all

	5.times do
    user = users.sample
		topic = Topic.create({
			:title => Faker::Lorem.word,
			:created_by => user.mail,
      :image_file => "/uploads/default" + rand(1..6).to_s + ".png"
		})
	end
end

def update_sub_topic
	topics = Topic.all
	users = User.all

	topics.each do |topic|
		5.times do
			sample_users = users.sample(rand(1..7))
			topic.sub_topics << SubTopic.new(
  			:title => Faker::Lorem.sentence,
  			:created_by => users.sample.mail,
  			:descr => Faker::Lorem.paragraph,
  			:score => rand(-7..7),
			  )
      topic.save
		end
	end
end

def update_comments
  topics = Topic.all
	users = User.all

  topics.each do |topic|
    sub_topics = topic.sub_topics
    sub_topics.each do |sub_t|
      sample_users = users.sample(rand(1..7))
      sample_users.each do |user|
        sub_t.comments << Comment.new(
          :mail => user.mail,
          :body => Faker::Lorem.sentence,
          )
        topic.save
      end
    end
  end
 end
