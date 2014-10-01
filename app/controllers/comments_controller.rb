class CommentsController < ApplicationController

	def show 
    @comment = Comment.new
  end  

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      flash[:notice] = "your comment #{@comment.body } has been saved"
    end
      redirect_to post_path(@post)  
  end

  def index
    @comment = Comment.all
    if @comment > 0
      Comment.count
     end 
  end

  # private
  #   def comment_params
  #     params.require(:comment).permit(:user, :body)
  #   end

end
