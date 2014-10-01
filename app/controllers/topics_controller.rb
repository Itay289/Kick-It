class TopicsController < ApplicationController

	def show

	end

	def index
		@topics = Topic.all		
	end
	
end
