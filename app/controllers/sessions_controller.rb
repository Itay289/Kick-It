class SessionsController < ApplicationController

	def new
		
	end

	def create
		user = User.find_by(mail: params[:session][:mail])
		if user  
				sign_in user  
       	redirect_to root_path 
       	flash[:success] = "You are signed in as #{user.mail}"
		else	
				flash.now[:error] = "invalid email"
				render 'new'   
		end	
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
