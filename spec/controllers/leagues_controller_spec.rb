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

    it 'renders the show template - non-private, visitor' do
      get :show, params: { slug: public_league.slug }

      expect(response).to render_template :show
    end

    it 'renders the show template - private, member'
    it 'renders the show template - private, admin'
    it 'redirects to dashboard path - private, non-member'
    it 'redirects to sign in path - private, visitor'
  end

  context 'GET#new'
  context 'POST#create'
  context 'GET#edit'
  context 'PATCH#update'
end
