# frozen_string_literal: true

require 'test_helper'

class UserAuthenticateTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:mike)
  end

  test "can't get index of users unless logged in" do
    sign_out :user
    get users_path
    assert_response :redirect
  end

  test "can't get edit user unless logged in" do
    sign_out :user
    get edit_user_registration_path
    assert_response :redirect
  end

  test "can't view user unless logged in" do
    sign_out :user
    get user_path(1)
    assert_response :redirect
  end

  test 'can edit user since logged in' do
    get edit_user_registration_path
    assert_response :success
  end

  test 'can get users index since logged in' do
    get users_path
    assert_response :success
  end
end
