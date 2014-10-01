class Topic
	include MongoMapper::Document
	key :title , String
	key :image , String
	key :created_by , String

	timestamps!
end
