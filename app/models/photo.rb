class Photo < ApplicationRecord
    has_many :photos_reactions, dependent: :destroy
    belongs_to :user
    belongs_to :album, optional: true
    attr_accessor :image_url
    mount_uploader :image_url, ImageUrlUploader

    # validates :user_id, presence: true
    validates :album_id, presence: true, allow_nil: true
    validates :title, length: { maximum: 140 }
    validates :description, length: { maximum: 300 }
    # validates :image_url, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
                    # size:{ less_than: 5.megabytes, message: "should be less than 5MB" }
    
    scope :public_photos, -> { where(:is_private => false)}
    scope :private_photos, -> { where(:is_private => true)}

    before_create :increase_number_photos
    before_destroy :decrease_number_photos
                
    def display_image
        image.variant(resize_to_limit: [500, 500])
    end

    def increase_number_photos
        if self.album_id
            album = Album.find(self.album_id)
            album.number_photos += 1
            album.save
        end
    end

    def decrease_number_photos
        if self.album_id
            album = Album.find(self.album_id)
            album.number_photos -= 1
            album.save
        end
    end
end
