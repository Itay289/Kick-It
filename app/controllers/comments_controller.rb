class CommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create]

	def new 
    @topic = Topic.where(active: true).find_by(title: params[:topic_id])
    @subtopic = @topic.sub_topics.where(active: true).find_by(id: params[:id])
    @comment = Comment.new
  end  

  def create
    @topic = Topic.find_by(title: params[:topic_id])
    @subtopic = @topic.sub_topics.where(active: true).find_by(id: params[:id])
    comment = Comment.new(
      :mail => cookies[:mail],
      :body => params[:comment][:body],

      )
    @subtopic.comments << comment
    @subtopic.save
    redirect_to topic_sub_topic_path(:id => @subtopic.id)
  end

  private
    def comment_params
      params.require(:comment).permit(:mail, :body)
    end
    
end
