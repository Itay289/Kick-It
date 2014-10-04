module SessionsHelper

	def sign_in(user)
		cookies.permanent[:mail] = user.mail
		self.current_user =  user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		User.find_by_mail(cookies[:mail]) if cookies[:mail]
	end

	def current_user?(user)
		user == current_user
	end

	def store_location
		session[:return_to] = request.fullpath
	end

  def signed_in_user
    unless signed_in?
      store_location # set at the session helper
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end  
  end
end
