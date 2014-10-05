class TopicsController < ApplicationController
	before_filter :signed_in_user, only: [:new]

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
