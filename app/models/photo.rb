class Photo < ApplicationRecord
    belongs_to :user
    belongs_to :album, optional: true
    mount_uploader :image_url, ImageUrlUploader

    # validates :user_id, presence: true
    # validates :album_id, presence: true, allow_nil: true
    validates :title, length: { maximum: 140 }
    # validates :description, presence: true, length: { maximum: 300 }
    # validates :image_url, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
    #                 size:{ less_than: 5.megabytes, message: "should be less than 5MB" }
    def display_image
        image.variant(resize_to_limit: [500, 500])
    end
end
