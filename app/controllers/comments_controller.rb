class CommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create]

	def new 
    @topic = Topic.find_by(title: params[:topic_id])
    @subtopics = @topic.sub_topics
    @subtopic = nil
    @subtopics.each do |sub_t|
      if sub_t.id.to_s == params[:id]
        @subtopic = sub_t
      end
    end
    @comment = Comment.new
    das
  end  

  def create
    @topic = Topic.find_by(title: params[:topic_id])
    subtopics = @topic.sub_topics
    @subtopic = nil
    subtopics.each do |sub_t|
      if sub_t.id.to_s == params[:id]
        @subtopic = sub_t
      end
    end
    comment = Comment.new(
      :name => "shahaf name",
      :mail => "shahaf mail",
      :body => params[:comment][:body],

      )
    @subtopic.comments << comment
    @topic.save
    redirect_to topic_sub_topic_path(:id => @subtopic.id)
  end

  def index
    # @comment = Comment.all(subtopic: params[:subtopic_id])
    # if @comment > 0
    #   Comment.count
    #  end 
  end

  private
    def comment_params
      params.require(:comment).permit(:mail, :body, :name)
    end
    
end
