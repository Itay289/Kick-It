class User
	include Mongoid::Document
	
	field :mail , type: String
  field :admin, type: Boolean, default: false

	validates :mail, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end