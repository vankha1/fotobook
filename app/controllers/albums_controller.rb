class AlbumsController < ApplicationController
    def index
        
    end

    def new 
        @album = Album.new
    end

    def create
        @album = current_user.albums.new(album_params)
        @photos = params[:album][:photos]

        if @album.save!
            redirect_to @album, notice: 'Album was successfully created.'
        else
            render :new
        end
    end

    def edit
         
    end
    
    def discover
         
    end

    private

    def album_params
        params.require(:album).permit(:title, :description, :is_private, photos_attributes: [:title, :description, :image_url, :is_private])
    end


    def photo_params
        params.require(:photo).permit(:title, :description, :image_url, :is_private)
    end
end