class UsersController < ApplicationController

    before_action :authenticate_user!, only: [:edit, :update]

    def index
    end

    def new 
        
    end

    def show
        @user = User.find(params[:id])
        @photo_count = @user.photos.count
        @album_count = @user.albums.count
        @following_count = @user.following.count
        @follower_count = @user.followers.count
        # Check url has photos or albums
        if request.path.include? "photos"
            @photos = @user.photos
        elsif request.path.include? "albums"
            @albums = @user.albums
        elsif request.path.include? "followings"
            @users = @user.following
        elsif request.path.include? "followers"
            @users = @user.followers
        end
    end

    # def show_follow
    #     @user = User.find(params[:id])
        
    #     render 'show'
    # end

    def following?(other_user)
        following_users.include?(other_user)
    end

    def edit
        @user = current_user
    end

    def update
        # update current_user
        if current_user.update(user_params)
            flash[:success] = "Profile updated"
            redirect_to current_user
        else
            render 'edit'
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :avatar, :password, :password_confirmation, :reset_password_token)
    end
end