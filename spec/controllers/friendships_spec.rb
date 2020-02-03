# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:second_user) { FactoryBot.create(:user) }
  let(:friend) { FactoryBot.create(:friend) }
  let(:another_user) { FactoryBot.create(:friend) }
  let(:requester) { FactoryBot.create(:friend) }

  describe '#create' do
    context 'logged in user' do
      before { sign_in user }

      context 'when none friend' do
        it 'creates an unconfirmed friendship' do
          Friendship.create(friend: user, user: second_user)
          check_friendship = user.friend?(second_user)
          expect(check_friendship).to be_falsy
        end
      end

      context 'when sent to already existing friend' do
        it 'creates no friendship' do
          Friendship.create(friend: user, user: second_user)
          user.accept_request(second_user)
          expect do
            post :create, params: { friendship: { user_id: user.id, friend_id: second_user.id } }
          end.not_to change(user.friendships, :count)
        end
      end
    end

    context 'when not the correct user' do
      before { sign_in second_user }

      it 'will not create friendship' do
        expect do
          post :create, params: { friendship: { user_id: user.id, friend_id: second_user.id } }
        end.not_to change(user.friendships, :count)
      end
    end

    context 'when not logged in' do
      before { post :create, params: { friendship: { user_id: user.id, friend_id: friend.id } } }
      it 'has no success' do
        expect(response).not_to be_successful
      end

      it 'rather redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    before do
      Friendship.create(friend: user, user: second_user)
      user.accept_request(second_user)
    end

    context 'when not logged in' do
      it 'doesnt delete the friendship' do
        expect do
          delete :delete, params: { request: { friend: second_user } }
        end.not_to change(user.friends, :count)
      end
    end
  end
end
