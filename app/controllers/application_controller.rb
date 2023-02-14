class ApplicationController < ActionController::Base
  def validate_user
    if (session[:id]).nil?
    flash[:error] = "Must be a registered user"
    redirect_to login_path
    end
  end
end
