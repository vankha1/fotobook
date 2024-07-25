class AlbumsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :restrict_admin_access, only: [:index, :new, :create, :discover]

    def index
        if user_signed_in?
            following_ids = current_user.followers.pluck(:id)
            @albums = Album.where(user_id: following_ids).public_albums
                            .order(created_at: :desc)
                            .paginate(page: params[:page], per_page: 4)
        else
            @albums = Album.public_albums.order(created_at: :desc).first(20).paginate(page: params[:page], per_page: 4)
        end
    end

    def new 
        @album = Album.new
        @album.photos.build
    end

    def create
        if params[:album][:photos_attributes]
            params[:album][:photos_attributes] = params[:album][:photos_attributes].except("0")
        else
            params[:album][:number_photos] = 0
        end
        @album = current_user.albums.new(album_params)
        @album.photos.each do |photo|
            photo.user_id = current_user.id
            photo.is_private = @album.is_private
        end
        
        if @album.save!
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
        # params[:album][:is_private] = params[:album][:is_private] != "Public" ? true : false
        # @number_photos = params[:album][:photos_attributes].values.reject { |photo| photo['_destroy'] == '1' || photo['_destroy'] == true }.count
        
        if @album.update(album_params)
            if current_user.is_admin?
                redirect_to (admin_albums_path), notice: 'Album was successfully updated.'
            else
                redirect_to ('/users/' + current_user.id.to_s + '/albums'), notice: 'Album was successfully updated.'
            end
        else
            render :edit
        end
    end

    def show 
        
    end

    def destroy
        @album = Album.find(params[:id])
        @album.destroy
        if current_user.is_admin?
            redirect_to (admin_albums_path), notice: 'Album was successfully updated.'
        else
            redirect_to ('/users/' + current_user.id.to_s + '/albums'), notice: 'Album was successfully deleted.'
        end
    end     
    def discover
        @albums = Album.public_albums.order(created_at: :desc).all
    end

    private

    def album_params
        params.require(:album).permit(:title, :description, :is_private, :number_photos, photos_attributes: [:user_id, :image_url, :_destroy, :id])
    end
end