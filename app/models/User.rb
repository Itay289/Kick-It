class User
	include Mongoid::Document
	
	field :mail , type: String

	validates :mail, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end