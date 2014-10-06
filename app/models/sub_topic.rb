class SubTopic
	include Mongoid::Document
  include Mongoid::Timestamps

  field :title , type: String 
	field :created_by , type: String 
	field :desc , type: String
	field :users , type: Array , default:  []
	field :score , type: Integer , default: 0
  
  embedded_in :topic
  embeds_many :comments

end