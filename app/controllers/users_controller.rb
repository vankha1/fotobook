class UsersController < ApplicationController

    before_action :authenticate_user!, only: [:edit, :update]

    def index
    end

    def new 
        
    end

    def show
        # Eager load associations to reduce database queries
        @user = User.includes(:photos, :albums, :following, :followers).find(params[:id])

        # Count associations using the loaded data to avoid extra queries
        @photo_count = @user.photos.length
        @album_count = @user.albums.length
        @following_count = @user.followers.length
        @follower_count = @user.following.length

        # Determine the content to load based on the request path
        content_type = case request.path
                    when /photos/
                        :photos
                    when /albums/
                        :albums
                    when /followings/
                        :followers
                    when /followers/
                        :following
                    end

        # Load the appropriate content based on the current user and content type
        if content_type
            if current_user
                is_current_user = current_user.id.to_s == params[:id]
            else
                is_current_user = false
            end
            @content = case content_type
                    when :photos
                        is_current_user ? @user.photos : @user.photos.public_photos
                    when :albums
                        is_current_user ? @user.albums : @user.albums.public_albums
                    else
                        @user.send(content_type) # For :following and :followers
                    end
        end
    end

    # def show_follow
    #     @user = User.find(params[:id])
        
    #     render 'show'
    # end

    def following?(other_user)
        following_users.include?(other_user)
    end

    def edit
        @user = current_user
    end

    def update
        # update current_user
        @user = current_user
        if @user.update(user_params)
            flash[:success] = "Profile updated"
            redirect_to '/users/' + @user.id.to_s + '/photos'
        else
            [:first_name, :last_name, :email].each do |attribute|
                if @user.errors[attribute].any?
                  flash["#{attribute}_error"] = attribute.to_s.gsub('_', ' ') + " " + @user.errors[attribute].first
                end
            end
            redirect_to edit_user_registration_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :avatar, :password, :password_confirmation, :reset_password_token)
    end
end