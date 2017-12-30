require 'rails_helper'

describe 'Visitor can sign up', type: :feature do
  before do
    visit sign_up_path

    fill_in 'E-Mail Address', with: 'test@example.com'
    fill_in 'First Name', with: 'Mark'
    fill_in 'Last Name', with: 'Miranda'
  end

  scenario 'redirects to dashboard path - successful sign up' do
    fill_in 'Password', with: 'password'
    click_button 'Sign Up'

    expect(current_path).to eq dashboard_path
    expect(page).to have_content 'test@example.com'
    expect(page).to have_content 'Mark Miranda'
  end

  it 'renders the new template - unsuccessful sign up' do
    click_button 'Sign Up'

    expect(page).to have_button 'Sign Up'
  end
end
