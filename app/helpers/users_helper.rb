# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image = user.image || gravatar_url
    image_tag(image, alt: user.nickname, class: 'gravatar')
  end

  def posts_exist?(user)
    !user.posts.empty?
  end

  def nickname(user)
    return 'Nickname not set' if user.nickname.blank?

    user.nickname
  end

  def location(user)
    return 'Location not set' if user.location.blank?

    user.location
  end

  def gender(user)
    return 'Gender not set' if user.gender.blank?

    user.gender
  end

  def age(user)
    return 'Age not set' if user.age.blank?

    user.age
  end
end
