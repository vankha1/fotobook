class UsersController < ApplicationController
    def index
    end

    def new 
        
    end

    def show
        @user = User.find(params[:user_id])
        # Check url has photos or albums
        if request.path.include? "photos"
            @photos = @user.photos.paginate(page: params[:page], per_page: 3)
        elsif request.path.include? "albums"
            @albums = @user.albums.paginate(page: params[:page], per_page: 3)
        end
    end

    def show_follow
        @user = User.find(params[:user_id])
        if request.path.include? "followings"
            @users = @user.following.paginate(page: params[:page], per_page: 3)
        elsif request.path.include? "followers"
            @users = @user.followers.paginate(page: params[:page], per_page: 3)
        end
        render 'show'
    end

    def edit
         
    end
end