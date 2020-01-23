# frozen_string_literal: true

require 'test_helper'

class LikesTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:mike)
  end

  def setup
    @post = posts(:post1)
  end

  test 'can like a post' do
    get post_path(@post)
    assert_template 'posts/show'
    assert_select 'button>a', text: "#{@post.likes.count} likes"
  end
end
