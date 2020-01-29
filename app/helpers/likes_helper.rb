# frozen_string_literal: true

module LikesHelper
  def likeables_data(likeables)
    { like: { likeables_id: likeables.id, likeables_type: likeables.class.name } }
  end

  def liked?(likeables)
    !likeables.likes.find_by(user_id: current_user.id).nil?
  end

  def like_id(likeables)
    likeables.likes.find_by(user_id: current_user.id).id
  end
end
