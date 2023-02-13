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
        user = user_params
        user[:email] = user[:email].downcase

        if user[:password] == params[:user][:password_confirmation]     
            new_user = User.create(user)
            if new_user.save
                redirect_to user_path(new_user)
                flash[:success] = "Welcome, #{new_user.name}!"
            else  
                flash[:error] = new_user.errors.full_messages.to_sentence
                redirect_to register_path
            end 
        else
            flash[:error] = 'Passwords must match'
            redirect_to register_path
        end
    end 

    def login_form

    end

    def login_user
        user = User.find_by(email: params[:email])
        if user.authenticate(params[:password])
            flash[:success] = "Welcome, #{user.name}!"
            redirect_to user_path(user.id)
        else
            flash[:error] = "Wrong Credentials"
            render :login_form
        end
    end

    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password)
    end 
end 