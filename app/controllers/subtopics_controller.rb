class SubtopicsController < ApplicationController

	def show
		puts params
		@sub_topics = Sub_topic.find(params[:id])
	end

	def index
		@sub_topics = Sub_topic.all(topic: params[:topic_id])      #Person.all(:last_name => 'Nunemaker', :order => 'first_name')
	end

	def new
		@subtopics = Sub_topic.new
	end

	def create
		@sub_topics = Sub_topic.new(params[:id])
		@Sub_topic.save
		flash[:success] = "Subject created successfully"
		redirect_to topic_subtopics_path
	end

	def destroy
		@sub_topics = Sub_topic.find(params[:id]).destroy
		flash[:success] = "Subject destroyed."
	end

	private

    def signed_in_user
      unless signed_in?
        store_location # set at the session helper
        redirect_to signin_path, notice: "Please sign in." unless signed_in?
      end  
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end
	
end
