class UsersController <ApplicationController 
    before_action :validate_user, only: :show

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
        new_user = User.create(user)
        if new_user.save
            session[:user_id] = new_user.id
            redirect_to user_path(new_user)
            flash[:success] = "Welcome, #{new_user.name}!"
        else  
            flash[:error] = new_user.errors.full_messages.to_sentence
            redirect_to register_path
        end 
    end 

    def login_form

    end

    def login_user
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "Welcome, #{user.name}!"
            redirect_to user_path(user.id)
        else
            flash[:error] = "Wrong Credentials"
            render :login_form
        end
    end

    def logout_user
        session.delete(:user_id)
        redirect_to '/'
    end

    private 

    def user_params 
        params[:user][:email].downcase!
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 