class PhotosReaction < ApplicationRecord
    belongs_to :photo
    belongs_to :user, optional: true
    validates :photo_id, presence: true
    validates :user_id, presence: true
end