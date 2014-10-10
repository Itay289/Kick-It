class TopicsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create, :destroy]
	before_filter :correct_user, only: :destroy

	def show

	end

	def index
		@topics = Topic.all		
	end

	def new
		@topics = Topic.new
	end

	def create
		uploader = ImageUploader.new
		uploader.store!(params[:topic][:image])
		# byebug
		@topic = Topic.new(
			:title => params[:topic][:title],
      :image => uploader.url,
			:created_by => cookies[:mail],
			)
		if @topic.save
			flash[:success] = "Subject created successfully"
    	redirect_to topics_path
    else
      flash[:error] = "Fields can't be blank"
      redirect_to :back  
    end  	
	end

	def destroy	
		if current_user.mail == Topic.find_by(id: params[:id]).created_by
			@topic.destroy
			flash[:success] = "Kick destroyed."
			redirect_to :back
		else
			flash[:error] = "You cant destroy this Kick."
			redirect_to :back
		end
	end

	def edit
    @topic = Topic.find_by(title: params[:id])
    if current_user.mail != @topic.created_by
      flash[:notice] ="Sorry, you can't edit this Kick"
      redirect_to :back
    end  
  end

  def update
  	uploader = ImageUploader.new
		uploader.store!(params[:topic][:image])
    @topic = Topic.find_by(id: params[:id])
    if @topic.update(secure_params)
      flash[:notice] = "Your Kick #{@topic.title} has been updated" 
      redirect_to root_path
    else
      flash[:error] = "Fields can't be blank"
      redirect_to :back    
    end  
  end

	private

    def correct_user
      @topic = Topic.find_by(id: params[:id])
      redirect_to root_url if @topic.nil?
    end

    def secure_params
      params.require(:topic).permit(:title, :image)
    end
	
end
