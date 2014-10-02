class Comment
	include MongoMapper::EmbeddedDocument
	# belongs_to :user

	key :name , String
	key :mail , String
  key :body , String

	timestamps!
end