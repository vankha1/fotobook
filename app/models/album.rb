class Album < ApplicationRecord
    has_many :photos, dependent: :destroy, before_add: :handle_before_add 
    has_many :albums_reactions, dependent: :destroy
    accepts_nested_attributes_for :photos, allow_destroy: true
    belongs_to :user
    
    validates :user_id, presence: true
    validates :title, presence: true, length: { maximum: 140 }
    validates :description, presence: true, length: { maximum: 300 }
    validates :number_photos, numericality: { only_integer: true, less_than_or_equal_to: 25 }
    
    # before_validation :add_default_number_photos
    before_create :add_default_number_likes

    scope :public_albums, -> { where(:is_private => false)}
    scope :private_albums, -> { where(:is_private => true)}

    def handle_before_add(photo)
        photo.user_id = self.user_id
    end

    def add_default_number_photos
        self.number_photos = 0
    end

    def add_default_number_likes
        self.number_like = 0
    end
end
