class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def validate_user
    if session[:user_id].nil?
        flash[:error] = "You must be logged in to access a user dashboard. Please log in or register."
        redirect_to '/'
    end
  end
end
