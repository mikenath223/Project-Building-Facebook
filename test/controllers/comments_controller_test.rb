# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test 'should get redirected' do
    get new_comment_url
    assert_response :redirect
  end
end
