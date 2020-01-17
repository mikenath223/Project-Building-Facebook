# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:mike)
  end

  test 'should be valid' do
    assert @user.valid?
  end
end
