class Topic
	include MongoMapper::Document
  many :subtopics

	key :title , String
	key :image , String
	key :created_by , String

	timestamps!
end
