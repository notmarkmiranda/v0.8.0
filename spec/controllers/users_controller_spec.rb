require 'rails_helper'

describe UsersController, type: :controller do
  context 'GET#show'
  context 'GET#new' do
    it 'renders the new template - non-signed-in user' do
      get :new

      expect(response).to render_template :new
    end

    it 'redirects to dashboard path - signed-in user'
  end

  context 'POST#create' do
    let(:attrs) { attributes_for(:user) }

    it 'redirects to dashboard path - successful creation' do
      post :create, params: { user: attrs }

      expect(response).to redirect_to dashboard_path
    end

    it 'renders the new template - unsuccessful creation' do
      post :create, params: { user: attrs.except(:email) }

      expect(response).to render_template :new
    end

    it 'redirects to dashboard path - signed-in user'
  end

  let(:user) { create(:user) }
  context 'GET#edit' do
    it 'renders the edit template' do
      get :edit, session: { user_id: user.id }

      expect(response).to render_template :edit
    end

    it 'redirects to root path - visitor'
  end

  context 'PATCH#update' do
    it 'redirects to dashboard path - successful update' do
      patch :update, session: { user_id: user.id }, params: { user: { first_name: 'Mark' } }

      expect(response).to redirect_to dashboard_path
    end

    it 'renders the edit template - unsuccessful update' do
      patch :update, session: { user_id: user.id }, params: { user: { first_name: '' } }

      expect(response).to render_template :edit
    end
    it 'redirects to root path - visitor'
  end
end
