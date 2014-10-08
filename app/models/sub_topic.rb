class SubTopic
	include Mongoid::Document
  include Mongoid::Timestamps

  field :title , type: String 
	field :created_by , type: String 
	field :descr , type: String
	field :score , type: Integer , default: 0
  
  embedded_in :topic
  embeds_many :comments
  embeds_many :votes

end