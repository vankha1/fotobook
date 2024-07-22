module UsersHelper
    def active_nav_class(path)
        'active_profile_nav' if request.path.include?(path)
    end

    def nav_link_count(path, user)
        case path
        when 'photos'
            user.photos.size
        when 'albums'
            user.albums.size
        when 'followings'
            @following_count
        when 'followers'
            @follower_count
        else
            0
        end
    end
end