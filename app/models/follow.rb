class Follow < ApplicationRecord
    belongs_to :follower, class_name: "User" # follower correspond to follower_id in follow model
    belongs_to :user, class_name: "User" # user correspond to user_id in follow model
    
    validates :user_id, presence: true
    validates :follower_id, presence: true
end
