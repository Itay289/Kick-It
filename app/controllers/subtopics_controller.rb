class SubtopicsController < ApplicationController
  helper_method :change_score

	def show
    @topic = Topic.find_by_title(params[:topic_id])
    @sub_topic = @topic.subtopics
    puts "hhhhhhh"
    puts @sub_topic
    # @comments = @sub_topic.comments
	end

	def index
      @topic = Topic.find_by_title(params[:topic_id])
      @sub_topics = @topic.subtopics
	end

  def new
    @topic = Topic.find_by_title(params[:topic_id])
    @subtopic = Sub_topic.new()
	end

	def create
    args = params[:sub_topic]
    args[:topic] = params[:topic_id]
    # TODO : change created_by to the user -> params[:session][:mail]
    args[:created_by] = "me"
    @sub_topic = Sub_topic.new(args)
		@sub_topic.save
    puts @sub_topic.inspect()
		flash[:success] = "Subject created successfully"
		redirect_to topic_subtopics_path
	end

	def destroy
		@sub_topics = Sub_topic.find(params[:id]).destroy
		flash[:success] = "Subject destroyed."
	end

  def change_score(item_id , interval)

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
