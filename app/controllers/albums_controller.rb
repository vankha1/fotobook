class AlbumsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        if user_signed_in?
            # Show all photos of following users
            @list_following = current_user.followers
            @albums = []
            @list_following.each do |user|
                @albums += user.albums.public_albums
            end

            @albums = @albums.sort_by{|album| album[:created_at]}.paginate(page: params[:page], per_page: 4)
        else
            # Show photos of all users
            @albums = Album.paginate(page: params[:page], per_page: 4)
        end
    end

    def new 
        @album = Album.new
        @album.photos.build
    end

    def create
        params[:album][:is_private] = params[:album][:is_private] != "Public"
        params[:album][:number_photos] = params[:album][:photos_attributes].keys.length - 1 || 0
        params[:album][:photos_attributes] = params[:album][:photos_attributes].except("0")
        @album = current_user.albums.new(album_params)
        @album.photos.each do |photo|
            photo.user_id = current_user.id
            photo.is_private = @album.is_private
        end
        
        if @album.save
            redirect_to ('/users/' + current_user.id.to_s + '/albums'), notice: 'Album was successfully created.'
        else
            render :new
        end
    end

    def edit
        @album = Album.find(params[:id])
    end

    def update
        @album = Album.find(params[:id])
        params[:album][:is_private] = params[:album][:is_private] != "Public" ? true : false
        @number_photos = params[:album][:photos_attributes].values.reject { |photo| photo['_destroy'] == '1' || photo['_destroy'] == true }.count
        
        if @album.update(album_params)
            @album.update_attribute(:number_photos, @number_photos)
            redirect_to ('/users/' + current_user.id.to_s + '/albums'), notice: 'Album was successfully updated.'
        else
            render :edit
        end
    end

    def show 
        
    end

    def destroy
        @album = Album.find(params[:id])
        @album.destroy
        redirect_to ('/users/' + current_user.id.to_s + '/albums'), notice: 'Album was successfully deleted.'
    end     
    def discover
        @albums = Album.public_albums.all
    end

    private

    def album_params
        params.require(:album).permit(:title, :description, :is_private, :number_photos, photos_attributes: [:user_id, :image_url, :_destroy, :id])
    end
end