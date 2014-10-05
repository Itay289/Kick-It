class CommentsController < ApplicationController

	def new 
    @comment = Comment.new
  end  

  def create
    @subtopic = Sub_topic.find(params[:id])
    @comment = @subtopic.comment.create(comment_params)
    if @comment.save
      flash[:notice] = "your comment #{@comment.body } has been saved"
    end
    redirect_to root_path
  end

  def index
    @comment = Comment.all(subtopic: params[:subtopic_id])
    if @comment > 0
      Comment.count
     end 
  end

  private
    def comment_params
      params.require(:comment).permit(:mail, :body, :name)
    end
    
end
