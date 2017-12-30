require 'rails_helper'

describe 'UserClubRole Admin is created for user when club is created', type: :request do
  let(:attrs) { attributes_for(:club) }
  let(:user)  { create(:user) }

  before do
    stub_current_(user)
  end

  it 'creates a club and ucr - successful creation' do
    expect {
      post '/clubs', params: { club: attrs }
    }.to change(UserClubRole, :count).by(1)
      .and change(Club, :count).by(1)
  end

  it 'does not create a club or ucr - unsuccessful creation' do
    expect {
      post '/clubs', params: { club: attrs.except(:name) }
    }.to_not change(UserClubRole, :count)
  end
end
