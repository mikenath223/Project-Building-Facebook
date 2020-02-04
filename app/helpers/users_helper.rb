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
    user.nickname || 'Nickname not set'
  end

  def location(user)
    user.location || "We don't know where you are"
  end

  def gender(user)
    user.gender || 'We dont know what you are'
  end

  def age(user)
    user.age || "We don't know how old you are"
  end
end
