# frozen_string_literal: true

require 'test_helper'

class UserAuthenticateTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:mike)
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
    get edit_post_path(1)
    assert_response :success
  end
end
