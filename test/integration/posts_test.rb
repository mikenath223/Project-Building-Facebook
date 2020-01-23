# frozen_string_literal: true

require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:mike)
  end

  def setup
    @post = posts(:post1)
  end

  test "can't get index of posts unless logged in" do
    sign_out :user
    get posts_path
    assert_response :redirect
  end

  test "can't get edit posts unless logged in" do
    sign_out :user
    get edit_user_registration_path
    assert_response :redirect
  end

  test "can't view posts unless logged in" do
    sign_out :user
    get user_path(1)
    assert_response :redirect
  end

  test 'can edit posts since logged in' do
    get edit_post_path(@post)
    assert_response :success
  end

  test 'post show display if logged in' do
    get post_path(@post)
    assert_template 'posts/show'
    assert_select 'h1', text: 'Post'
    assert_select 'h3>img.gravatar'
  end

  test 'post index display if logged in' do
    get posts_path
    assert_template 'posts/index'
    assert_select 'h2', text: 'Post Feed'
    assert_select 'li>img.gravatar'
    assert_select 'li', text: "Title: #{@post.title}"
    assert_select 'li', text: @post.content
  end
end
