class Topic
	include MongoMapper::Document
  many :subtopics

	key :title , String, :required
	key :image , String
	key :created_by , String

	timestamps!
end
