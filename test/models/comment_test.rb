# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @post = posts(:post1)
    @comment = Comment.new(user_id: 1, post_id: 1, content: 'Hello there')
  end

  test 'user id must exist' do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test 'content should be present' do
    @comment.content = ' '
    assert_not @comment.valid?
  end
end
