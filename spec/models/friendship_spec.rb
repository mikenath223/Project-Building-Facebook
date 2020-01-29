require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it { is_expected.to have_db_column(:friend_id).of_type(:integer) }
  it { is_expected.to have_db_column(:confirmed).of_type(:boolean) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:friend) }
end
