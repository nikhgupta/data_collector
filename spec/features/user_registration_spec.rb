require 'rails_helper'

RSpec.describe 'User Registration' do
  let(:fake_user){ create :fake_user }
  let(:already_registered){ create :user }

  scenario "user registers by providing the correct UUID (external ID)" do
    visit new_user_registration_path
    fill_in "Email", with: "testuser@example.com"
    fill_in "Password", with: "password", exact: true
    fill_in "Password confirmation", with: "password"
    fill_in "UUID", with: fake_user.uuid
    click_button "Sign up"

    expect(page).to have_content "signed up successfully"
    expect(page).to have_content "No sensors found for your account"
    expect(page.current_path).to eq root_path
    expect(page).not_to have_highchart #.inside("#sensor-charts .chart")
  end

  scenario "user registers by providing UUID not in the system already" do
    visit new_user_registration_path
    fill_in "Email", with: "testuser@example.com"
    fill_in "Password", with: "password", exact: true
    fill_in "Password confirmation", with: "password"
    fill_in "UUID", with: "UNRECOGNIZED-UUID"
    click_button "Sign up"

    expect(page).to have_content "signed up successfully"
    expect(page).to have_content "No sensors found for your account"
    expect(page.current_path).to eq root_path
  end

  scenario "user registeration fails with a correct but already registered UUID" do
    visit new_user_registration_path
    fill_in "Email", with: "testuser@example.com"
    fill_in "Password", with: "password", exact: true
    fill_in "Password confirmation", with: "password"
    fill_in "UUID", with: already_registered.uuid
    click_button "Sign up"

    expect(page).to have_content "Uuid has already been taken"
    expect(page).to have_no_content "signed up successfully"
    expect(User.find_by(email: "testuser@example.com")).to be_nil

    visit dashboard_path
    expect(page.current_path).to eq new_user_session_path
  end

  scenario "user registeration fails when no UUID (external ID) is provided" do
    visit new_user_registration_path
    fill_in "Email", with: "testuser@example.com"
    fill_in "Password", with: "password", exact: true
    fill_in "Password confirmation", with: "password"
    fill_in "UUID", with: ""
    click_button "Sign up"

    expect(page).to have_content "Uuid can't be blank"
    expect(page).to have_no_content "signed up successfully"
    expect(User.find_by(email: "testuser@example.com")).to be_nil

    visit dashboard_path
    expect(page.current_path).to eq new_user_session_path
  end
end
