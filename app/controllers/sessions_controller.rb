class SessionsController < ApplicationController

	def new
		
	end

	def create
		user = User.find_by(mail: params[:session][:mail])
		if user  
			flash[:success] = "Hi #{user.mail.to_s.split('@').first} welcome back"   	
		else 
			user = User.create mail: params[:session][:mail]
			flash[:success] = "Welcome #{user.mail.to_s.split('@').first}"   
		end	
		sign_in user
		redirect_back_or root_path      	
	end

	def destroy
		sign_out
		redirect_to :back
	end

	def inde
		
	end

end
