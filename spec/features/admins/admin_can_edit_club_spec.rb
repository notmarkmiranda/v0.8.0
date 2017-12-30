require 'rails_helper'

describe 'Admin can edit club', type: :feature do
  let(:club)  { create(:club, privated: true) }
  let(:admin) { club.creator }

  before do
    stub_current_(admin)
  end

  scenario 'from dashboard, it redirects to club path - successful update' do
    visit dashboard_path

    click_link "Edit #{club.name}"
    fill_in 'Name', with: 'New Name'
    choose('club_privated_1')
    click_button 'Update Club'

    expect(current_path).to eq club_path(club.reload)
    expect(page).to have_content 'New Name'
  end

  scenario 'from club show, it redirects to club path - successful update' do
    visit club_path(club)

    click_link "Edit #{club.name}"
    fill_in 'Name', with: 'Other New Name'
    choose('club_privated_0')
    click_button 'Update Club'

    expect(current_path).to eq club_path(club.reload)
    expect(page).to have_content 'Other New Name'
  end

  scenario 'it renders the new template - unsuccessful update' do
    visit edit_club_path(club)

    fill_in 'Name', with: ''
    click_button 'Update Club'

    expect(page).to have_button 'Update Club'
  end

end
