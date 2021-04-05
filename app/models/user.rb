class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: :followed_id
  has_many :followeds, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :followed

  def followed_by?(user)
    passive_relationships.find_by(followed_id: user.id).present?
  end

  validates :name,uniqueness: true,
                  length: { minimum: 2, maximum: 20 }

  validates :introduction, length: { maximum: 50 }
end
