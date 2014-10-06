class SubTopicsController < ApplicationController
  helper_method :change_score
  before_filter :signed_in_user, only: [:new]
  # fffff
	def show
    @topic = Topic.find_by(title: params[:topic_id])
    @sub_topic = @topic.sub_topics.find_by(_id: params[:id])
    @comments =  @sub_topic.comments
	end

	def index
      @topic = Topic.find_by(title: params[:topic_id])
      @sub_topics = @topic.sub_topics
	end

  def new
    @topic = Topic.find_by(title: params[:topic_id])
    @subtopic = SubTopic.new
    Comment.new
	end

	def create
    @topic = Topic.find_by(title: params[:topic_id])
    # TODO : change created_by to the user -> params[:session][:mail]
    sub_topic = SubTopic.new(
      :created_by => "me",
      :desc => params[:sub_topic][:desc],
      :title => params[:sub_topic][:title],
      )
		@topic.sub_topics << sub_topic
    @topic.save
		flash[:success] = "Subject created successfully"
		redirect_to topic_sub_topics_path
	end

	def destroy
		@sub_topics = SubTopic.find(params[:id]).destroy
		flash[:success] = "Subject destroyed."
	end

  def change_score(item_id , interval)

  end

end
