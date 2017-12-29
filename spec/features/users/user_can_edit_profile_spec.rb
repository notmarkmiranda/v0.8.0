require 'rails_helper'

describe 'User can edit profile', type: :feature do
  let(:user) { create(:user, first_name: 'John') }

  before do
    stub_current_user(user)
    visit dashboard_path
    click_link 'Edit Profile'
  end

  scenario 'redirects to dashboard path - successful update' do
    fill_in 'First Name', with: 'Matthew'
    fill_in 'Password', with: '168Washu'
    click_button 'Update Profile'

    expect(current_path).to eq dashboard_path
    expect(page).to have_content 'Matthew'
    expect(page).to_not have_content 'John'
  end

  scenario 'renders the edit template - unsuccessful update' do
    fill_in 'First Name', with: ''

    click_button 'Update Profile'
    expect(page).to have_button 'Update Profile'
  end
end
