# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
5.times do |i|
    User.create!(first_name: "user#{i}", last_name: "user#{i}", email: "user#{i}@gmail.com", password: "123456", avatar: "https://anhanime.com/wp-content/uploads/2024/02/Anh-Nagi-dep.jpg")
end
User.all.each do |user|
    5.times do |i|
        user.photos.create!(title: "Photo#{i}",description: "This is photo of user #{user.first_name}", is_private: rand(2)==1, image_url: 'https://anhanime.com/wp-content/uploads/2024/02/Anh-Giyu-Tomioka-6.jpg')
        user.albums.create!(title: "Album#{i}",description: "This is album of user #{user.first_name}", is_private: rand(2)==1)
    end
end
Album.all.each do |album|
    5.times do |i|
        album.photos.create!(title: "Photo#{i}",description: "This is photo of album #{album.title} of #{album.user.first_name}", is_private: rand(2)==1, image_url: 'https://anhanime.com/wp-content/uploads/2024/02/Anh-Giyu-Tomioka-6.jpg')
    end
end
list_user_id=User.pluck(:id)
10.times do |i|
    Follow.create!(user_id: list_user_id[rand(list_user_id.length)], follower_id: list_user_id[rand(list_user_id.length)])
    # 2.times do |j|
    #     ReactAlbum.create!(user_id: list_user_id[rand(list_user_id.length)], album_id: Album.pluck(:id).sample)
    #     ReactPhoto.create!(user_id: list_user_id[rand(list_user_id.length)], photo_id: Photo.pluck(:id).sample)
    # end
end
