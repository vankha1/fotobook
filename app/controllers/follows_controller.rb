class FollowsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    
    def create
        @user = User.find(params[:follower_id])
        current_user.followers << @user
        # respond_to do |format|
        #     format.html { redirect_to '/discover/photos' }
        #     format.js
        # end
    end

    def destroy
        @user = User.find(params[:id])
        current_user.followers.delete(@user)
        # respond_to do |format|
        #     format.html { redirect_to '/discover/photos' }
        #     format.js
        # end
    end
end
