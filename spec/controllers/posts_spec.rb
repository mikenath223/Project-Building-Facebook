# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  before { @post = user.posts.create(FactoryBot.attributes_for(:post)) }

  describe '#index' do
    context 'not logged in' do
      it 'doesnt respond successfully' do
        get :index
        expect(response).not_to be_successful
      end
      it 'redirects to sign in path' do
        expect(response).to be_successful
      end
    end
  end

  describe '#show' do
    context 'not logged in' do
      before { get :show, params: { id: @post.id } }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end
      it 'redirects to sign in path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#new' do
    context 'Not logged in' do
      before { get :new, params: { user_id: user.id } }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end
      it 'redirects to sign in path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
