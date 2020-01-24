# frozen_string_literal: true

require 'rails_helper'
require 'models/concerns/likeable_spec'

RSpec.describe Comment, type: :model do
  it_behaves_like 'likeable'
end
