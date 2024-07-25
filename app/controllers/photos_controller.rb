class PhotosController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :restrict_admin_access, only: [:photo_feeds, :new, :create ,:discover]

    def index
        if user_signed_in?
            # Show all photos of following users
            @photos = current_user.photos.paginate(page: params[:page], per_page: 4)
        else
            # Show photos of all users
            @photos = Photo.public_photos.paginate(page: params[:page], per_page: 4)
        end
        render 'users/show'
    end

    def photo_feeds
        # For root path
        if user_signed_in?
            # Show all photos of following users
            following_ids = current_user.followers.pluck(:id)
            @photos = Photo.where(user_id: following_ids).public_photos
                   .order(created_at: :desc)
                   .paginate(page: params[:page], per_page: 4)
        else
            # Show photos of all users
            @photos = Photo.public_photos.order(created_at: :desc).first(20).paginate(page: params[:page], per_page: 4)
        end
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo = current_user.photos.new(photo_params)
        if @photo.save
            redirect_to ('/users/' + current_user.id.to_s + '/photos'), notice: 'Photo was successfully created.'
        else
            render :new
        end
    end

    def show
    end

    def edit
        @photo = Photo.find(params[:id])
    end

    def update
        @photo = Photo.find(params[:id])
        # if params[:image_url] == nil
        #     params[:image_url] = @photo.image_url
        # end
        
        if @photo.update(photo_params)
            if current_user.is_admin?
                redirect_to ('/admin/photos'), notice: 'Photo was successfully updated.'
            else
                redirect_to ('/users/' + current_user.id.to_s + '/photos'), notice: 'Photo was successfully updated.'
            end
        else
            render :edit
        end
    
    end

    def discover
        @photos = Photo.public_photos.where(album_id: nil).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end

    def destroy
        @photo = Photo.find(params[:id])
        @photo.destroy
        if current_user.is_admin?
            redirect_to (admin_photos_path), notice: 'Photo was successfully updated.'
        else
            redirect_to ('/users/' + current_user.id.to_s + '/photos'), notice: 'Photo was successfully destroyed.'
        end
    end

    def search
        key = "%#{params[:key]}%"
        combined_results = []

        if params[:key].present?
            photo_results = Photo.public_photos.where("title LIKE ? OR description LIKE ?", key, key)
            album_results = Album.where("title LIKE ? OR description LIKE ?", key, key)

            # Assuming Album has_many :photos and Photo responds to :image_url
            album_results = album_results.map do |album|
                album_attributes = album.attributes
                first_photo = album.photos.first
                album_attributes.merge!("image_url" => first_photo.try(:image_url) || "default_image_url_here")
                album_attributes.merge!("type" => "Album")
                # Append (album) to the title for album results
                album_attributes["title"] = "#{album_attributes["title"]} (album)"
                album_attributes
            end
    

            photo_results = photo_results.map do |photo|
            photo.attributes.merge("type" => "Photo", "image_url" => photo.image_url)
            end

            combined_results = photo_results + album_results
        end

        render json: combined_results
    end

    private

    def photo_params
        params.require(:photo).permit(:title, :description, :image_url, :is_private)
    end
    
end