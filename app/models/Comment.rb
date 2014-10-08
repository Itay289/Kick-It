class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

	field :mail , type: String
  field :body , type: String
  field :active , type: Boolean , default: true

  embedded_in :sub_topic

	validates :body, presence: true 

end