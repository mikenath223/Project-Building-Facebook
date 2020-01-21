# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, :title, presence: true, length: { maximum: 140 }

  has_many :likes, -> { distinct }, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
end
