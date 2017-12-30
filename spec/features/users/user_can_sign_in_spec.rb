require 'rails_helper'

describe 'User can sign in', type: :feature do
  let(:user) { create(:user) }

  before do
    visit sign_in_path
    fill_in 'E-Mail Address', with: user.email
  end

  scenario 'redirects to dashboard path - successful login' do
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(current_path).to eq dashboard_path
    expect(page).to have_content user.email
    expect(page).to have_content user.full_name
    expect(page).to have_link 'Edit Profile'
  end

  scenario 'renders the new template' do
    fill_in 'Password', with: 'passwordz'
    click_button 'Sign In'

    expect(page).to have_button 'Sign In'
  end
end
