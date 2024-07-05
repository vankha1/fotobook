class PhotosController < ApplicationController
    def index
        if user_signed_in?
            @photos = current_user.photos
        else
            @photos = Photo.all
        end
    end

    def new 
        
    end

    def edit
         
    end
    
end