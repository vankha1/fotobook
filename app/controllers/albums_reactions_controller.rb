class AlbumsReactionsController < ApplicationController
    def create
        @album = Album.find(params[:album_id])
        current_user.albums_reactions.create(user: current_user, album_id: params[:album_id])
        redirect_to @album
    end

    def destroy
        current_user.albums_reactions.where(album_id: params[:album_id]).destroy_all
        redirect_to @album
    end
end