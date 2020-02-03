# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         devise :omniauthable, omniauth_providers: %i[facebook]

  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :email, presence: true
  validates :nickname, :location, length: { maximum: 45 }
  validates :age, length: { maximum: 3 }

  has_many :friendships, dependent: :destroy
  has_many :rebound_friendships, class_name: :Friendship, foreign_key: :friend_id, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.nickname = auth.info.name
      # user.image = auth.info.image
    end
  end

  def friends
    friendships.where(confirmed: true).map(&:friend) + rebound_friendships.where(confirmed: true).map(&:user)
  end

  # Users with a linear relationship
  def friend_requests
    friendships.where(confirmed: nil).map(&:friend)
  end

  # Users who have requested to be friends thereby becoming the reverse of the relationship
  def rebound_requests
    rebound_friendships.where(confirmed: nil).map(&:user)
  end

  def accept_request(user)
    relationship = rebound_friendships.find { |friend_relation| friend_relation.user == user }
    relationship.update(confirmed: true)
    relationship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
