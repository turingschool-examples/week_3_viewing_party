require 'bcrypt'

class UsersController <ApplicationController 
    before_action :validate_user, only: :show
    def new 
        @user = User.new()
    end 

    def show 
        @user = User.find(params[:id])
    end 

    def create 
        user = User.create(user_params)
        if user.save
            session[:id] = user.id
            flash[:success] = "Welcome, #{user.name}"
            redirect_to user_path(user)
        else  
            flash[:error] = user.errors.full_messages.to_sentence
            redirect_to register_path
        end 
    end 

    def login_form

    end 

    def login_user
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:id] = user.id
            redirect_to "/users/#{user.id}"
        else 
            flash[:error] = "Bad Credentials, try again."
            redirect_to "/login" 
        end 
    end 

    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 