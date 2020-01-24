# frozen_string_literal: true

require 'spec_helper'
require 'models/concerns/likeable_spec'

RSpec.describe Post, type: :model do
  it_behaves_like 'likeable'

  it { is_expected.to have_db_column(:title).of_type(:string) }
  it { is_expected.to have_db_column(:content).of_type(:string) }
  it { is_expected.to have_db_column(:user_id).of_type(:integer) }
end
