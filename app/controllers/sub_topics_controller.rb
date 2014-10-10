class SubTopicsController < ApplicationController
  helper_method :change_score
  before_filter :signed_in_user, only: [:new, :create, :upvote, :destroy]
	def show
    @topic = Topic.find_by(title: params[:topic_id])
    @sub_topic = @topic.sub_topics.find_by(_id: params[:id])
    @comments =  @sub_topic.comments
	end

	def index
      @topic = Topic.find_by(title: params[:topic_id])
      @sub_topics = @topic.sub_topics.desc(:score)
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
      :created_by => cookies[:mail],
      :descr => params[:sub_topic][:descr],
      :title => params[:sub_topic][:title],
      )
		@topic.sub_topics << sub_topic
    if @topic.save
  		flash[:success] = "Subject created successfully"
  		redirect_to topic_sub_topics_path
    else
      flash[:error] = "Fields can't be blank"
      redirect_to :back  
    end  
	end

	def destroy
    if current_user.mail == Topic.find_by(title: params[:topic_id]).sub_topics.find_by(id: params[:id]).created_by
      Topic.find_by(title: params[:topic_id]).sub_topics.find_by(id: params[:id]).destroy
		  flash[:success] = "Subject destroyed." 
      redirect_to topic_sub_topics_path
    else
      flash[:error] = "You cant destroy this item."
      redirect_to :back       
    end  
	end

  def change_score
    @topic = Topic.find_by(title: params[:topic_id])
    @sub_topic = @topic.sub_topics.find_by(id: params[:id])
    if params[:count_action] == "like"
      @sub_topic.inc(score: 1)
      @topic.save
    elsif params[:count_action] == "dislike"
      @sub_topic.inc(score: -1)
      @topic.save
    end
    redirect_to topic_sub_topics_path   
  end

  def edit
    @topic = Topic.find_by(title: params[:topic_id])
    @sub_topic = @topic.sub_topics.find_by(id: params[:id])
    if current_user.mail != @sub_topic.created_by
      flash[:notice] ="Sorry, you can't edit this Kick"
      redirect_to :back
    end  
  end

  def update
    @sub_topic = Topic.find_by(title: params[:topic_id]).sub_topics.find_by(id: params[:id])
    if @sub_topic.update(secure_params)
      flash[:notice] = "Your Item #{@sub_topic.title} has been updated" 
      redirect_to topic_sub_topic_path
    else
      flash[:error] = "Fields can't be blank"
      redirect_to :back      
    end  
  end

  def upvote
    topic = Topic.find_by(title: params[:topic_id])
    sub_topic = topic.sub_topics.find_by(id: params[:id])
    if sub_topic.votes.where(mail: cookies[:mail]).exists?
      if sub_topic.votes.find_by(mail: cookies[:mail]).voting == 1
        sub_topic.votes.find_by(mail: cookies[:mail]).set(voting: 0)
        sub_topic.inc(score: -1)
      else
        sub_topic.votes.find_by(mail: cookies[:mail]).set(voting: 1)
        sub_topic.inc(score: 1)
      end
    else
      sub_topic.votes << Vote.new(
        mail: cookies[:mail],
        voting: 1,
        )
      sub_topic.inc(score: 1)
    end
    topic.save!

    redirect_to topic_sub_topics_path
  end


  private
    
    def secure_params
      params.require(:sub_topic).permit(:title, :descr)
    end  

end
