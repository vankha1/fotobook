class Admin::AlbumsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!

    def index
        @albums = Album.all.paginate(page: params[:page], per_page: 12)
    end
end