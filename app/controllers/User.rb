class User
	include MongoMapper::Document
	
	key :name , String
	key :mail , String
end