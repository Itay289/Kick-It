class Subtopic
	include MongoMapper::EmbeddedDocument
  many :comments

	key :title , String
	key :created_by , String 
	key :desc , String
	key :users , Array , :default => []
	key :score , Integer , :default => 0

	timestamps!
end