# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post_) { FactoryBot.create(:post) }
  let(:comment) { FactoryBot.create(:comment) }
  let(:like) { FactoryBot.create(:like, user: user) }
  let(:likeable) { like.likeable }
  let(:like_params) { { likeable_id: likeable.id, likeable_type: likeable.class.name } }

  describe '#create' do
    context 'Is Logged in' do
      before { sign_in user }

      it 'adds a like to post' do
        expect do
          post :create, params: { like: { likeable_id: post_.id, likeable_type: 'Post' } }
        end.to change(post_.likes, :count).by(1)
      end

      it 'adds a like to comment' do
        expect do
          post :create, params: { like: { likeable_id: comment.id, likeable_type: 'Comment' } }
        end.to change(comment.likes, :count).by(1)
      end
    end

    context 'Not logged in' do
      before { post :create, params: { like: like_params } }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
