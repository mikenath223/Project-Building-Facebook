# frozen_string_literal: true

module LikesHelper
  def likeable_data(likeable)
    { like: { likeable_id: likeable.id, likeable_type: likeable.class.name } }
  end

  def liked?(likeable)
    !likeable.likes.find_by(user_id: current_user.id).nil?
  end

  def like_id(likeable)
    likeable.likes.find_by(user_id: current_user.id).id
  end
end
