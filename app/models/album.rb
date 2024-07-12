class Album < ApplicationRecord
    has_many :photos, dependent: :destroy, before_add: :handle_before_add 
    accepts_nested_attributes_for :photos, allow_destroy: true
    belongs_to :user
    
    validates :user_id, presence: true
    validates :title, presence: true, length: { maximum: 140 }
    validates :description, presence: true, length: { maximum: 300 }
    validates :number_photos, numericality: { only_integer: true, less_than_or_equal_to: 25 }

    def handle_before_add(photo)
        photo.user_id = self.user_id
    end
end
