class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!

    def index
        @users = User.all.order(created_at: :desc).paginate(page: params[:page], per_page: 12)
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        # Check if the password is blank
        if user_params[:password].blank?
            params[:user] = params[:user].except(:password) # Remove password from parameters if it's blank
        end

        if @user.update!(user_params)
            flash[:success] = "User updated successfully"
            redirect_to admin_users_path
        else
            render edit_admin_user_path(@user.id)
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            flash[:success] = "User deleted successfully"
            redirect_to admin_users_path
        else
            flash[:error] = "An error occurred while deleting the user"
            redirect_to admin_users_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :is_active, :password, :avatar)
    end
end