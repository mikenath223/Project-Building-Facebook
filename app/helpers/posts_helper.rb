# frozen_string_literal: true

module PostsHelper
  def comments?(post)
    post.comments
  end

  def get_user(var)
    var.user.nickname || var.user.email
  end

  def owner?(user)
    user == current_user
  end

  def attribute_exist?(post, attr)
    attr.where(user_id: current_user.id, post_id: post.id).exists?
  end

  def find_user(id)
    User.find(Post.find(id))
  end
end
