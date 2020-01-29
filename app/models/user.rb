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

  has_many :friendships
  has_many :inverse_friendships, class_name: :Friendship, foreign_key: :friend_id

  def friend?(user)
    friends.include?(user)
  end

  def friends
    friends_array = friendships.map { |friends| friends.friend if friends.confirmed }
    friends_array += inverse_friendships.map { |friends| friends.user if friends.confirmed }
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
   pending_friends = friendships.map { |friends| friends.friend unless friends.confirmed }.compact
   pending_friends
  end

  # Users who have requested to be friends
  def friend_requests
    requested_friendship = inverse_friendships.map { |friend_relation| friend_relation.user unless friend_relation.confirmed }.compact
  end

  def confirm_friend(user)
    relationship = inverse_friendships.find { |friend_relation| friend_relation.user == user }
    relationship.update(confirmed: true)
    relationship.save
  end
end
