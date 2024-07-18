class PhotosReactionsController < ApplicationController
    
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!

    def create
        @photo = Photo.find(params[:photo_id])
        current_user.photos_reactions.create!(photo_id: params[:photo_id])
        @photo.number_like += 1
        @photo.save
    end

    def destroy
        p params
        @photo = Photo.find(params[:id])
        current_user.photos_reactions.where(photo_id: params[:id]).destroy_all
        @photo.number_like -= 1
        @photo.save
    end
end