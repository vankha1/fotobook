class PhotosController < ApplicationController
    def index
        if user_signed_in?
            @photos = current_user.photos.paginate(page: params[:page], per_page: 3)
        else
            @photos = Photo.paginate(page: params[:page], per_page: 3)
        end
    end

    def new 
        
    end

    def edit
         
    end
    
end