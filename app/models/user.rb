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

  has_many :pending_friendships, -> { where confirmed: nil }, class_name: :Friendship, foreign_key: :user_id
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: :Friendship, foreign_key: :user_id
  has_many :pending_rebounds, -> { where confirmed: nil }, class_name: :Friendship, foreign_key: :friend_id
  has_many :confirmed_rebounds, -> { where confirmed: true }, class_name: :Friendship, foreign_key: :friend_id

  has_many :chatmessages, dependent: :destroy
  has_many :recieved_chats, class_name: :Chatmessage, foreign_key: :reciever_id, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.nickname = auth.info.name
      user.image = auth.info.image
    end
  end

  def chats(user)
    chats = recieved_chats.where(user_id: user) + chatmessages.where(reciever_id: user)
    chats.sort_by { |k, _v| k[:created_at] }
  end

  def friends
    friends = confirmed_friendships.eager_load(:friend).map(&:friend)
    rebounds = confirmed_rebounds.eager_load(:friend).map(&:user)
    (friends + rebounds).uniq
  end

  def friend_requests
    pending_friendships.eager_load(:friend).map(&:friend)
  end

  def rebound_requests
    pending_rebounds.eager_load(:friend).map(&:user)
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
