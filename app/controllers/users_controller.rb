require 'bcrypt'

class UsersController <ApplicationController 
    def index
        
    end
    def new 
        @user = User.new()
    end 

    def show 
        @user = User.find(params[:id])
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

    def password
        @password ||= Password.new(password_hash)
    end

    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end


    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 