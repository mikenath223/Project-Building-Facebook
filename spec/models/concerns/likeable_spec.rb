# frozen_string_literal: true

shared_examples 'likeable' do
  it { is_expected.to have_many(:likes) }
end
