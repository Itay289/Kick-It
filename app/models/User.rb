class User
	include Mongoid::Document
	
	field :mail , type: String
end