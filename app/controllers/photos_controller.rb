class PhotosController < ApplicationController
    def index
        @photos = User.find(2).photos
    end

    def new 
        
    end

    def edit
         
    end
    
end