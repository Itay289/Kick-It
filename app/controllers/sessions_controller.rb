class SessionsController < ApplicationController

	def new
		
	end

	def create
		user = User.find_by_mail(params[:session][:mail])
		if user 
				cookies[:mail] = user.mail  
       	redirect_to root_path 
		else	
				flash.now[:error] = "invalid email"
				render 'new'   
		end	
	end

end
