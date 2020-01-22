# frozen_string_literal: true

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = Like.new(post_id: posts(:post1).id, user_id: users(:mike).id)
  end

  test 'should be valid' do
    assert @like.valid?
  end

  test 'user_id should exist' do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test 'post_id should exist also' do
    @like.post_id = nil
    assert_not @like.valid?
  end
end
