class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session insteadd.
  protect_from_forgery with: :exception
  include SessionsHelper

  helper_method :show_name

  def show_name(subject)
    subject.created_by.to_s.split('@').first
  end
end
