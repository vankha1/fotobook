class AlbumsReactionsController < ApplicationController
    def create
        @album = Album.find(params[:album_id])
        current_user.albums_reactions.create!(album_id: params[:album_id])
        @album.number_like += 1
        @album.save
        respond_to do |format|
            format.html { redirect_to '/albums' }
            format.js 
        end
    end

    def destroy
        @album = Album.find(params[:id])
        current_user.albums_reactions.where(album_id: params[:id]).destroy_all
        @album.number_like -= 1
        @album.save
        respond_to do |format|
            format.html { redirect_to '/albums' }
            format.js 
        end
    end
end