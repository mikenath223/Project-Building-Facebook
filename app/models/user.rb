# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :email, presence: true
  validates :nickname, :location, length: { maximum: 45 }
  validates :age, length: { maximum: 3 }

  # belongs_to :post
  # belongs_to :user

  # validates :user_id, uniqueness: { scope: :post_id, message: 'You have already liked this post' }

  has_many :friendships, dependent: :destroy
  has_many :rebound_friendships, class_name: :Friendship, foreign_key: :friend_id, dependent: :destroy

  def friends
    friends = friendships.where(confirmed: true).map(&:friend) + rebound_friendships.where(confirmed: true).map(&:user)
  end

  # Users with a linear relationship
  def friend_requests
    friend_requests = friendships.where(confirmed: nil).map(&:friend)
  end

  # Users who have requested to be friends thereby becoming the reverse of the relationship
  def rebound_requests
    rebound_requests = rebound_friendships.where(confirmed: nil).map(&:user)
  end

  def accept_request(user)
    relationship = rebound_friendships.find { |friend_relation| friend_relation.user == user }
    relationship.update(confirmed: true)
    relationship.save
  end

  def friend?(user)
    friends.match(user)
  end
end
