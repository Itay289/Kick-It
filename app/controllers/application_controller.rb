class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session insteadd.
  protect_from_forgery with: :exception
  include SessionsHelper

end
