class PhotosController < ApplicationController
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
            @list_following = current_user.followers
            @photos = []
            @list_following.each do |user|
                @photos += user.photos.public_photos
            end
            @photos = @photos.sort_by{|photo| photo[:created_at]}.paginate(page: params[:page], per_page: 4)
        else
            # Show photos of all users
            @photos = Photo.public_photos.order(created_at: :desc).paginate(page: params[:page], per_page: 4)
        end
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo = current_user.photos.new(photo_params)
        if @photo.save!
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
            redirect_to ('/users/' + current_user.id.to_s + '/photos'), notice: 'Photo was successfully updated.'
        else
            render :edit
        end
    
    end

    def discover
        @photos = Photo.public_photos.where(album_id: nil)
    end

    def destroy
        @photo = Photo.find(params[:id])
        @photo.destroy
        redirect_to ('/users/' + current_user.id.to_s + '/photos'), notice: 'Photo was successfully destroyed.'
    end

    private

    def photo_params
        params.require(:photo).permit(:title, :description, :image_url, :is_private)
    end
    
end