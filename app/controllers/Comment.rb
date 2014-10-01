class Comment
	include MongoMapper::Document
	# belongs_to :user

	key :name , String
	key :mail , String
  key :body , String

	timestamps!
end