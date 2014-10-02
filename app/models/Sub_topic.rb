class Sub_topic
	include MongoMapper::Document
  many :comments
	# belongs_to :topic

	key :title , String
	key :created_by , String 
	key :desc , String
	key :users , Hash , :default => {}
	key :score , Integer , :default => 0
	key :topic , String 

	timestamps!
end