class Album < ApplicationRecord
    has_many :photos, dependent: :destroy 
    accepts_nested_attributes_for :photos, allow_destroy: true
    belongs_to :user
    
    validates :user_id, presence: true
    validates :title, presence: true, length: { maximum: 140 }
    validates :description, presence: true, length: { maximum: 300 }
    validates :number_photos, numericality: { only_integer: true, less_than_or_equal_to: 25 }
end
