class AlbumsController < ApplicationController
    def index
        
    end

    def new 
        @album = Album.new
        @album.photos.build
    end

    def create
        @album = current_user.albums.new
        @album.title = params[:album][:title]
        @album.description = params[:album][:description]
        @album.is_private = params[:album][:is_private] != "Public"
        # @album.number_photos = params[:album][:photos_attributes]
        p params[:album][:photos_attributes]["0"]
        @album.save!

        @album.photos.create(params[:photo])

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
        params.require(:album).permit(:title, :description, :is_private, photos_attributes: [:image_url, :_destroy])
    end
    
    def photo_params
        params.require(:photo).permit(:title, :description, :image_url, :is_private)
    end
    
end