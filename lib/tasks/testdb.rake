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

    # puts "done"
  end
end

def clean_data
	users = User.all
	users.each { |user| user.destroy() }

	topics = Topic.all
	topics.each { |topic| topic.destroy() }

	# sub_topics = SubTopic.all
	# sub_topics.each { |sub| sub.destroy()}

	# comments = Comment.all
	# comments.each { |com| com.destroy()}
end

def update_users
	names = []
	5.times do 
		names.push(Faker::Name.first_name)
	end
	names.push('shahaf','itay')

	names.each do |name|
		user = User.create({
			:name => name,
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
			:image => 'imageplaceholder',
			:created_by => user.name,
		})
	end
end

def update_sub_topic
	topics = Topic.all
	users = User.all

	topics.each do |topic|
		5.times do
			sample_users = users.sample(rand(1..7))
			topic.subtopics << Subtopic.new(
  			:title => Faker::Lorem.sentence,
  			:created_by => users.sample.mail,
  			:desc => Faker::Lorem.paragraph,
  			:users => [{ :mail => 'shahaf255@.com' , :vote => 1}],
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
    sub_topics = topic.subtopics
    sub_topics.each do |sub_topic|
      sample_users = users.sample(rand(1..7))
      sample_users.each do |user|
        sub_topic.comments << Comment.new(
          :name => user.name,
          :mail => user.mail,
          :body => Faker::Lorem.sentence,
          )
        topic.save
      end
    end
  end
 end
         #  SubTopic.all(:conditions => {'comments.name' => 'shahaf'})

