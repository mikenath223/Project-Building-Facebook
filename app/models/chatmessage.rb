class Chatmessage < ApplicationRecord
  belongs_to :user
  belongs_to :reciever, class_name: :User

  validates :message, presence: true, length: { maximum: 250 }
end
