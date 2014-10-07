class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :mail , type: String
  field :voting , type: Integer 

  embedded_in :sub_topic
end