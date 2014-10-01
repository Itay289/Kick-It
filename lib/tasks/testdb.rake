namespace :dbtest do
  desc "Fill database with sample data"
  task populate: :environment do
    clean_data
    update_topic
    update_sub_topic
    update_comments
  end
end

def clean_data
	topics = Topic.all
	topics.each { |topic| topic.destroy() }

	sub_topics = Sub_topic.all
	sub_topics.each { |sub| sub.destroy()}

	comments = Comment.all
	comments.each { |com| com.destroy()}

end

def update_topic
	5.times do
		topic = Topic.create({
			:title => Faker::Lorem.word,
			:image => 'imageplaceholder',
			:created_by => Faker::Name.name,
		})
	end
end

def update_sub_topic
	topics = Topic.all

	topics.each do |topic|
		5.times do
			sub = Sub_topic.create({
			:title => Faker::Lorem.sentence,
			:created_by => 'john',
			:desc => Faker::Lorem.paragraph,
			:users => { :mail => 'shahaf255@.com' , :vote => 1},
			:score => Faker::Number.digit,
			:topic => topic.title
			})
		end
	end
end

def update_comments
	com = Comment.create({
		:name => 'shahaf',
		:mail => 'shahaf255@gmail.com'
		})

end

