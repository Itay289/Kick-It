class TopicsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create, :destroy]
	before_filter :correct_user, only: :destroy

	def show

	end

	def index
		@topics = Topic.where(active: true).all
		if @topics == nil
			@topics = []
		end		
	end

	def new
    @title = "Create new Kick"
		@topic = Topic.new
	end

	def create
    puts params
		uploader_image_file = ImageUploader.new
    uploader_image_file.store!(params[:topic][:image_file])
    uploader_image_url = ImageUploader.new
    uploader_image_url.store!(params[:topic][:image_url])
		@topic = Topic.new(
			title: params[:topic][:title],
      image_file: uploader_image_file.url,
      image_url: uploader_image_url.url,
			created_by: cookies[:mail],
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
		if current_user.mail == Topic.find_by(title: params[:id]).created_by
			@topic.destroy
			flash[:success] = "Kick destroyed."
			redirect_to :back
		else
			flash[:error] = "You cant destroy this Kick."
			redirect_to root_path
		end
	end

	def edit
    @title = "Edit Your Kick"
    @topic = Topic.find_by(title: params[:id])
    if current_user.mail != @topic.created_by
      flash[:notice] ="Sorry, you can't edit this Kick"
      redirect_to :back
    end  
    render :new
  end

  def update
  	uploader_image_file = ImageUploader.new
    uploader_image_file.store!(params[:topic][:image_file])
    uploader_image_url = ImageUploader.new
    uploader_image_url.store!(params[:topic][:image_url])
    params[:topic][:image_file] = uploader_image_file.url
    params[:topic][:image_url] = uploader_image_url.url
    @topic = Topic.find_by(title: params[:id])
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
      @topic = Topic.find_by(title: params[:id])
      redirect_to root_url if @topic.nil?
    end

    def secure_params
      params.require(:topic).permit(:title, :image_file, :image_url)
    end
	
end
