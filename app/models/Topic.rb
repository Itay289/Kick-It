class Topic
	include Mongoid::Document
  include Mongoid::Timestamps

  field :title , type: String
  field :image, type: String, default: "/uploads/default1.png"
	field :created_by , type: String
  field :active , type: Boolean , default: true

  embeds_many :sub_topics

  validates :title, presence: true

  def to_param
    title
  end

end
