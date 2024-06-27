class User < ApplicationRecord
  # The people that this user follows
  has_many :active_follows, class_name: "Follow", foreign_key: "user_id", dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy

  has_many :followers, through: :active_follows, source: :follower
  has_many :following, through: :passive_follows, source: :followed
end
