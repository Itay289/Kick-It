class TopicsController < ApplicationController

	def show

	end

	def index
		@topics = Topic.all		
	end

	def new
		@topics = Topic.new
	end

	def create
		puts "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
		puts params[:topic]
		@topics = Topic.new(params[:topic])
		@topics.save
		flash[:success] = "Subject created successfully"
		redirect_to topics_path
	end
	
end
