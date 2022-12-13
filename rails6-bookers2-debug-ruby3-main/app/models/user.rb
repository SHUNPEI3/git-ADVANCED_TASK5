class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :bool_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  has_many :follower, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed

  has_many :followed, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :followed_user, through: :followed, source: :follower


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

  def following?(user)
    following_user.include?(user)
  end

end