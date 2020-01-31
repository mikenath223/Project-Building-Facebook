# frozen_string_literal: true

module LikesHelper
  def likeable_data(likeable)
    { like: { likeable_id: likeable.id, likeable_type: likeable.class.name.capitalize } }
  end

  def liked?(likeable)
    likeable.likes.where(user_id: current_user.id).exists?
  end

  def like_id(likeable)
    likeable.likes.where(user_id: current_user.id).ids
  end
end
