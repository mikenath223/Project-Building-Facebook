# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, :title, presence: true, length: { maximum: 140 }

  default_scope -> { order(created_at: :desc) }
end
