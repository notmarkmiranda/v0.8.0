require 'rails_helper'

describe ClubsController, type: :controller do
  let(:club)  { create(:club) }
  let(:admin) { club.creator }
  let(:user)  { create(:user) }

  context 'GET#show' do
    it 'renders the show template' do
      get :show, params: { slug: club.slug }

      expect(response).to render_template :show
    end
  end

  context 'GET#new' do
    it 'renders the new template - logged-in user' do
      get :new, session: { user_id: user.id }

      expect(response).to render_template :new
    end

    it 'redirects to root path - visitor' do
      get :new

      expect(response).to redirect_to root_path
    end
  end

  context 'POST#create' do
    let(:attrs) { attributes_for(:club) }
    it 'redirects to club path - successful create' do
      post :create, session: { user_id: user.id }, params: { club: attrs }

      expect(response).to redirect_to club_path(Club.last)
    end

    it 'renders the new template - unsuccessful create' do
      post :create, session: { user_id: user.id }, params: { club: attrs.except(:name) }

      expect(response).to render_template :new
    end

    it 'redirects to root path - visitor' do
      post :create, params: { club: attrs }

      expect(response).to redirect_to root_path
    end
  end

  context 'GET#edit' do
    it 'renders the edit template' do
      get :edit, session: { user_id: admin.id }, params: { slug: club.slug }

      expect(response).to render_template :edit
    end

    xit 'redirects to dashboard path - non-admin user' do
      get :edit, session: { user_id: user.id }, params: { slug: club.slug }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to dashboard path - non-admin member'
    it 'redirects to sign in path - visitor'
  end

  context 'PATCH#update' do
    it 'redirects to club show path - successful update' do
      patch :update, session: { user_id: admin.id }, params: { slug: club.slug, club: { name: 'newer name' } }

      expect(response).to redirect_to club_path(club.reload)
    end

    it 'renders the new template - unsuccessful update' do
      patch :update, session: { user_id: admin.id }, params: { slug: club.slug, club: { name: '' } }

      expect(response).to render_template :edit
    end
    it 'redirects to dashboard path - non-admin user'
    it 'redirects to dashboard path - non-admin member'
    it 'redirects to sign in path - visitor'
  end
end
