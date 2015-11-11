require 'rails_helper'

RSpec.feature "User Authorization" do
  let(:user){ create :user }

  scenario "user logins with correct credentials" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content "Signed in successfully"
    expect(page.current_path).to eq root_path
  end

  scenario "user logins with incorrect credentials" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpassword"
    click_button "Log in"

    expect(page).to have_content "Invalid email or password"
    expect(page.current_path).to eq new_user_session_path
  end
end
