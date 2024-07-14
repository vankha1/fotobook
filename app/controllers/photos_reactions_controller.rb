class PhotosReactionsController < ApplicationController
    
    before_action :find_photo

    def create
        @photo = Photo.find(params[:photo_id])
        current_user.photos_reactions.create!(photo_id: params[:photo_id])
        @photo.number_like += 1
        @photo.save
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js 
        end
    end

    def destroy
        @photo = Photo.find(params[:id])
        current_user.photos_reactions.where(photo_id: params[:id]).destroy_all
        @photo.number_like -= 1
        @photo.save
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js 
        end
    end

    private

    def find_photo
        photoId = params[:photo_id] || params[:id]
        photos = Photo.find(photoId)
    end
end