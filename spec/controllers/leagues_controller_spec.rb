require 'rails_helper'

describe LeaguesController, type: :controller do
  context 'GET#show' do
    let(:public_league)  { create(:league, :public) }
    let(:private_league) { create(:league, :private) }
    let(:user)           { create(:user) }
    let(:private_member) do
      private_league.grant_membership(user)
      user
    end
    let(:private_admin) do
      private_league.grant_adminship(user)
      user
    end

    it 'renders the show template - non-private, visitor' do
      get :show, params: { slug: public_league.slug }

      expect(response).to render_template :show
    end

    it 'renders the show template - private, member' do
      get :show, session: { user_id: private_member.id }, params: { slug: private_league.slug }

      expect(response).to render_template :show
    end

    it 'renders the show template - private, admin' do
      get :show, session: { user_id: private_admin.id }, params: { slug: private_league.slug }

      expect(response).to render_template :show
    end

    it 'redirects to dashboard path - private, non-member' do
      get :show, session: { user_id: user.id }, params: { slug: private_league.slug }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to sign in path - private, visitor' do
      get :show, params: { slug: private_league.slug }

      expect(response).to redirect_to sign_in_path
    end
  end

  it 'GET#new'
  it 'POST#create'
  it 'GET#edit'
  it 'PATCH#update'
end
