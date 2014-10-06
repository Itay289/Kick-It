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
		@current_user ||= User.find_by(mail: cookies[:mail]) if cookies[:mail]
	end

	def current_user?(user)
		user == current_user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:mail)
	end

	def store_location
		a = request.fullpath
		a.sub!(/comments/, '')
		session[:return_to] = a
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

  def signed_in_user
    unless signed_in?
      store_location # set at the session helper
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end  
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
  end

end
