class Chatmessage < ApplicationRecord
  belongs_to :user
  belongs_to :reciever, class_name: :User

end
