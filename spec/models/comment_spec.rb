# frozen_string_literal: true

require 'rails_helper'
require 'models/concerns/likeable_spec'

RSpec.describe Comment, type: :model do
  it_behaves_like 'likeable'
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }

  it { is_expected.to have_db_column(:content) }
end
