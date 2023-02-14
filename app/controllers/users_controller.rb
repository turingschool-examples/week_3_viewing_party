class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      flash[:error] = 'You must be logged in to access your dashboard'
      redirect_to root_path
    end
  end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to user_path(user)
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:error] = 'Bad Credentials, try again.'
      redirect_to '/login'
    end
  end

  def logout_user
    session.delete('user_id')
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
