# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.nickname, class: 'gravatar')
  end

  def posts_exist?(user)
    !user.posts.empty?
  end

  def nickname(_user)
    @user.nickname || 'Nickname not set'
  end

  def location(_user)
    @user.location || "We don't know where you are"
  end

  def gender(_user)
    @user.gender || 'We dont know what you are'
  end

  def age(_user)
    @user.age || "We don't know how old you are"
  end
end
