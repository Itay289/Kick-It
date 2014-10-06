class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name , type: String
	field :mail , type: String
  field :body , type: String

  embedded_in :sub_topic


end