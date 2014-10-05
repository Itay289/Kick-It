class TopicsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create]

	def show

	end

	def index
		@topics = Topic.all		
	end

	def new
		@topics = Topic.new
	end

	def create
		uploader = ImageUploader.new
		uploader.store!(params[:topic][:image])
		@topic = Topic.new(
			:title => params[:topic][:title],
			:image => uploader.url,
			:created_by => "stam",
			)
		@topic.save

		flash[:success] = "Subject created successfully"
		redirect_to topics_path
	end
	
end
