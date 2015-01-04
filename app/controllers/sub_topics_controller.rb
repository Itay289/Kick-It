class SubTopicsController < ApplicationController
  helper_method :user_voted
  before_filter :signed_in_user, only: [:new, :create, :upvote, :destroy]
	
  def show
    begin 
      @topic = Topic.where(active: true).find_by(title: params[:topic_id])
      @sub_topic = @topic.sub_topics.where(active: true).find_by(_id: params[:id])
      @comments =  @sub_topic.comments.where(active: true)
    rescue
      redirect_to root_path
    end
	end

	def index
    begin
      @topic = Topic.where(active: true).find_by(title: params[:topic_id])
      @sub_topics = @topic.sub_topics.where(active: true).desc(:score)
    rescue
      redirect_to root_path
    end
	end

  def new
    @title = "Create New Kick"
    @topic = Topic.find_by(title: params[:topic_id])
    @subtopic = SubTopic.new
	end

	def create
    topic = Topic.find_by(title: params[:topic_id])
    topic.sub_topics << SubTopic.new(
      :created_by => cookies[:mail],
      :descr => params[:sub_topic][:descr],
      :title => params[:sub_topic][:title],
      url: params[:sub_topic][:url],
      anonymous: params[:sub_topic][:anonymous]
      )
    if topic.save
  		flash[:success] = "Subject created successfully"
  		redirect_to topic_sub_topics_path
    else
      flash[:error] = "Fields can't be blank"
      redirect_to :back  
    end  
	end

	def destroy
    if current_user.mail == owner_of(params[:topic_id], params[:id])
      Topic.find_by(title: params[:topic_id]).sub_topics.find_by(id: params[:id]).set(active: false)
		  flash[:success] = "Subject destroyed." 
      redirect_to topic_sub_topics_path
    else
      flash[:error] = "You cant destroy this item."
      redirect_to :back       
    end  
	end

  def edit
    @title = "Update Your Kick"
    @topic = Topic.find_by(title: params[:topic_id])
    @subtopic = @topic.sub_topics.find_by(id: params[:id])
    if current_user.mail != @subtopic.created_by
      flash[:notice] ="Sorry, you can't edit this Kick"
      redirect_to :back
    end
    render :new
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
    # byebug
    if sub_topic.votes.find_by(mail: cookies[:mail])
      if sub_topic.votes.find_by(mail: cookies[:mail]).voting == 1
        sub_topic.votes.find_by(mail: cookies[:mail]).destroy
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
    # bug on mongoid - creating empty instances 
    # https://github.com/mongoid/mongoid/issues/2735
    sub_topic.votes.where(mail: nil).destroy
    topic.save

    redirect_to topic_sub_topics_path
  end

  def user_voted(subtopic_id)
    begin
      topic = Topic.find_by(title: params[:topic_id])
      subtopic = topic.sub_topics.find_by(id: subtopic_id)
      subtopic.votes.where(mail: cookies[:mail]).last.voting == 1 
    rescue
      false
    end
  end


  private
    
    def secure_params
      params.require(:sub_topic).permit(:title, :descr, :url)
    end 

    def owner_of(topic_title, sub_topic_id)
      Topic.find_by(title: topic_title).sub_topics.find_by(id: sub_topic_id).created_by
    end

end
