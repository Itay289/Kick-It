class SubTopicsController < ApplicationController
  helper_method :change_score
  before_filter :signed_in_user, only: [:new, :create, :upvote, :destroy]
	def show
    begin 
      @topic = Topic.where(active: true).find_by(title: params[:topic_id])
      @sub_topic = @topic.sub_topics.where(active: true).find_by(_id: params[:id])
      @comments =  @sub_topic.where(active: true).comments
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
    @topic = Topic.find_by(title: params[:topic_id])
    @subtopic = SubTopic.new
    Comment.new
	end

	def create
    @topic = Topic.find_by(title: params[:topic_id])
    # TODO : change created_by to the user -> params[:session][:mail]
    sub_topic = SubTopic.new(
      :created_by => cookies[:mail],
      :descr => params[:sub_topic][:desc],
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


  protected



end
