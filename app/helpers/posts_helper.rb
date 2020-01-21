# frozen_string_literal: true

module PostsHelper

    def has_comments?(post)
        post.comments
    end

    def get_user(var)
       # User.find(comment.user_id)
       var.user.nickname ? var.user.nickname : var.user.email
    end

    def owner?(user)
        user == current_user
    end

end
