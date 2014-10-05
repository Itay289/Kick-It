class Topic
	include MongoMapper::Document
  many :sub_topics

	key :title , String
	key :image , String
	key :created_by , String

	timestamps!
end
