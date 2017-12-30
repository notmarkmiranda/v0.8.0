require 'rails_helper'

describe 'Logged-in user can log out spec' do
  let(:user) { create(:user) }

  scenario 'redirects to root path' do
    visit sign_in_path

    fill_in 'E-Mail Address', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_link 'Sign Out'

    click_link 'Sign Out'

    expect(current_path).to eq root_path
  end
end
