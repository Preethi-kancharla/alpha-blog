class UsersController < ApplicationController
    before_action:set_user , only: [:show, :edit, :update]


    def new
        @user = User.new
    end

    def index
        @users = User.all
    end

    def show
        
    end

    def edit

    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
            redirect_to articles_path
        else
            render 'new'
    
        end
    end

    def update

        if @user.update(user_params)
            flash[:notice] = "Your account is successfully updated"
            redirect_to @user
        else
            render 'edit'
        end
        
    end

    private

        def user_params
            params.require(:user).permit(:username, :email, :password)
        end

        def set_user
            begin
                @user = User.find(params[:id])
                @articles = @user.articles
            rescue ActiveRecord::RecordNotFound
                render :json => "404 page not found"
            end
        end

end