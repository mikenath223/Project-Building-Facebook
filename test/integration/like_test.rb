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
    assert_difference 'Like.count', 1 do
      post post_likes_path(@post), params: { post: { id: 1 } }
    end
    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_match "1 like", response.body
    assert_difference 'Like.count', -1 do
      delete post_like_path(@post)
    end
  end
end