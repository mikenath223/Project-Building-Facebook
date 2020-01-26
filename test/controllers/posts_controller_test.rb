# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'should get redirected' do
    get new_post_url
    assert_response :redirect
  end
end
