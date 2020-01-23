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
  validates :nickname, :location, length: { maximum: 10 }
  validates :age, length: { maximum: 3 }

  # belongs_to :post
  # belongs_to :user

  # validates :user_id, uniqueness: { scope: :post_id, message: 'You have already liked this post' }
end
