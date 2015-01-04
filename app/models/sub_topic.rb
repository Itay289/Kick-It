class SubTopic
	include Mongoid::Document
  include Mongoid::Timestamps

  field :title , type: String 
	field :created_by , type: String 
	field :descr , type: String
	field :score , type: Integer , default: 0
  field :active , type: Boolean , default: true
  field :url, type: String
  field :anonymous, type: Boolean , default: false
  
  embedded_in :topic
  embeds_many :comments
  embeds_many :votes

  validates :title, presence: true 

  def can_edit?(user)
    self.created_by == user.mail || user.admin?
  end

end