class UsersController < ApplicationController


    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @checked = params[:checked].present?
        @user = User.new 
      end

      def create
        @user = User.new(user_params)
        if @user.save
          if should_stay?
            redirect_to new_user_path(checked: true)
          else
            redirect_to user_path(@user), notice: "User created!"
          end
        else
          render :new
        end
      end

      def edit
        @user = User.find(params[:id])
      end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path(@user)
        else
            render :edit
        end
    end



      private
      
      def user_params
        params.require(:user).permit(:username, :email, :password)
      end

      def should_stay?
        params[:should_stay].present?
      end

end
