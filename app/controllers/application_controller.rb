class ApplicationController < ActionController::Base
    require 'will_paginate/array'

    # Redirect admin to another page
    def after_sign_in_path_for(resource)
        if current_user.is_admin?
            admin_photos_path
        else
            root_path
        end
    end

    # Check if user is admin
    def authenticate_admin!
        unless current_user.is_admin?
            redirect_to root_path
        end
    end
end
