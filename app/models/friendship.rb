# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  validates :user, :friend, presence: true
  # validate :not_friend_self
  # validate :non_existence, on: :create

  # private

  # def not_friend_self
  #   errors.add(:not_friend_self, 'You can\'t friend yourself!') if user == friend
  # end

  # def non_existence
  #   return if Friendship.find_by(user: user, friend: friend).nil?

  #   errors.add(:unique_relation, 'Relationship already exists.')
  # end
end
