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
        # require 'pry'; binding.pry
        user = User.find_by(email: params[:email])
        # require 'pry'; binding.pry
        if user && user.authenticate(params[:password])
            flash[:success] = "Welcome, #{user.email}!"
            redirect_to user_path(user.id) 
        else
            flash[:error] = 'Log In Failed'
            render :login_form
        end
    end

    # def password
    #     @password ||= Password.new(password_hash)
    # end

    # def password=(new_password)
    #     @password = Password.create(new_password)
    #     self.password_hash = @password
    # end


    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 