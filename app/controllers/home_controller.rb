class HomeController < ApplicationController

	def show

	end

	def index
		@topics = Topic.all
	end

end
