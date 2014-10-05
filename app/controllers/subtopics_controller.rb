class SubtopicsController < ApplicationController
  helper_method :change_score
  before_filter :signed_in_user, only: [:new]

	def show
    @topic = Topic.find_by_title(params[:topic_id])
    @sub_topics = @topic.subtopics
    @sub_topic = nil
    @sub_topics.each do |sub_t|
      if sub_t.id.to_s == params[:id]
        @sub_topic = sub_t
      end
    end
    @comments =  @sub_topic.comments
	end

	def index
      @topic = Topic.find_by_title(params[:topic_id])
      @sub_topics = @topic.subtopics
	end

  def new
    @topic = Topic.find_by_title(params[:topic_id])
    @subtopic = Sub_topic.new()
    @comment.new()
	end

	def create
    puts "ggggggggggg"
    puts params
    @topic = Topic.find_by_title(params[:topic_id])
    # TODO : change created_by to the user -> params[:session][:mail]
    sub_topic = Subtopic.new(
      :created_by => "me",
      :desc => params[:sub_topic][:desc],
      :title => params[:sub_topic][:title],
      )
		@topic.subtopics << sub_topic
    @topic.save
		flash[:success] = "Subject created successfully"
		redirect_to topic_subtopics_path
	end

	def destroy
		@sub_topics = Sub_topic.find(params[:id]).destroy
		flash[:success] = "Subject destroyed."
	end

  def change_score(item_id , interval)

  end

end
