class Topic
	include MongoMapper::Document
	key :title , string
	key :image , string
	key :created_by , string
end