require 'rails_helper'

describe 'User can create a club', type: :feature do
  let(:user) { create(:user) }

  before do
    stub_current_(user)
    visit dashboard_path
    click_link 'Create New Club'
  end

  scenario 'redirects to club path - successful creation' do
    fill_in 'Name', with: 'Club Miranda'
    choose('club_privated_0')
    click_button 'Create Club'

    expect(current_path).to eq(club_path(Club.last))
    expect(page).to have_content('Club Miranda')
  end

  scenario 'redirects to club path - successful creation' do
    fill_in 'Name', with: 'Club Miranda'
    choose('club_privated_1')
    click_button 'Create Club'

    expect(current_path).to eq(club_path(Club.last))
    expect(page).to have_content('Club Miranda')
  end

  scenario 'renders the new template - unsuccessful create' do
    fill_in 'Name', with: ''
    click_button 'Create Club'

    expect(page).to have_button 'Create Club'
  end
end
