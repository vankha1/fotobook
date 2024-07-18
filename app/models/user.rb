class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  
  mount_uploader :avatar, AvatarUploader
  has_many :photos, dependent: :destroy
  has_many :photos_reactions, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :albums_reactions, dependent: :destroy
  has_many :active_follows, class_name: "Follow", foreign_key: "user_id", dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy

  has_many :followers, through: :active_follows, source: "follower"
  has_many :following, through: :passive_follows, source: "user"

  before_save :downcase_email

  validates :first_name, presence: true, length: {maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: {minimum: 6, maximum: 64}, allow_nil: true  
  
  def self.from_google(u)
    puts u
    create_with(id: u[:uid], provider: 'google',
                password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email], first_name: u[:first_name], last_name: u[:last_name], avatar: u[:avatar])
  end

  private
    def downcase_email
      self.email.downcase!
    end

end
