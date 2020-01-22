require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @post = posts(:post1)
    @comment = @post.comments.build(content: "Hello there")
  end

  test 'should be valid' do
    assert @comment.valid?
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
