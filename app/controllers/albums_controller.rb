class AlbumsController < ApplicationController
    def index
        if user_signed_in?
            # Show all photos of following users
            @list_following = current_user.followers
            @albums = []
            @list_following.each do |user|
                @albums += user.albums.where(is_private: false).order('created_at DESC')
            end

            @albums = @albums.paginate(page: params[:page], per_page: 3)
        else
            # Show photos of all users
            @albums = Album.paginate(page: params[:page], per_page: 3)
        end
    end

    def new 
        @album = Album.new
        @album.photos.build
    end

    def create
        @album = current_user.albums.new
        # puts album_params, "+++++++++++++"
        # @album.photos.each do |photo|
        #     puts photo.user_id
        #     puts photo.album_id
        #     puts photo.image_url
        # end

        @album.title = params[:album][:title]
        @album.description = params[:album][:description]
        @album.is_private = params[:album][:is_private] != "Public"
        @album.number_photos = params[:album][:photos_attributes].keys.length - 1 || 0

        if @album.save!
            params[:album][:photos_attributes].keys.each do |key|
                if key != "0"
                    @photo = @album.photos.new(image_url: params[:album][:photos_attributes][key][:image_url], user_id: current_user.id)
                    @photo.save!
                    puts @album.photos, "##############"
                    puts params[:album][:photos_attributes][key][:image_url], "+++++++"
                end
            end
            redirect_to '/albums', notice: 'Album was successfully created.'
        else
            render :new
        end
    end

    def edit
         
    end

    def show 
        
    end
    
    def discover
        @albums = Album.all
    end

    private

    def album_params
        params.require(:album).permit(:title, :description, :is_private, photos_attributes: [:user_id, :image_url, :_destroy])
    end
end