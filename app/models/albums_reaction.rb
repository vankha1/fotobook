class AlbumsReaction < ApplicationRecord
    belongs_to :album
    belongs_to :user, optional: true
    validates :album_id, presence: true
    validates :user_id, presence: true
end