class PhotosController < ApplicationController
    def index
        if user_signed_in?
            # Show all photos of following users
            @photos = current_user.photos.paginate(page: params[:page], per_page: 3)
        else
            # Show photos of all users
            @photos = Photo.paginate(page: params[:page], per_page: 3)
        end
        render 'users/show'
    end

    def photo_feeds
        # For root path
        if user_signed_in?
            # Show all photos of following users
            @photos = current_user.photos.paginate(page: params[:page], per_page: 3)
        else
            # Show photos of all users
            @photos = Photo.paginate(page: params[:page], per_page: 3)
        end
    end

    def new 
        
    end

    def show
    end

    def edit
         
    end

    def discover
        @photos = Photo.all
    end
    
end