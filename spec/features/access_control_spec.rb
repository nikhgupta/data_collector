require 'rails_helper'

RSpec.describe 'Access Control' do
  let(:user){ create :user, email: "testuser@example.com", name: "Test User" }
  let(:admin){ create :admin, email: "superadmin@example.com", name: "Super Admin" }
  let(:another_user){ create :user, email: "another@example.com", name: "Another User" }
  let(:sensor){ create :sensor, user: user, uuid: "ABCDEFGH" }
  let(:another_sensor){ create :sensor, user: admin, uuid: "STUVWXYZ" }
  let(:sensor_datum){ create :sensor_datum, sensor: sensor }
  let(:another_sensor_datum){ create :sensor_datum, sensor: another_sensor }
  let(:aggregate){ create :minute_aggregate_point, sensor: sensor }
  let(:another_aggregate){ create :minute_aggregate_point, sensor: another_sensor }

  context "when logged in user is an admin" do
    before(:each){ login_as admin }

    scenario "listing, creation and deletion of users is allowed" do
      visit dashboard_path
      expect(page).to have_link "Users"

      click_link "Users"

      expect(page).to have_link "New User"
      within "#user_#{admin.id}" do
        expect(page).to have_selector ".col-name", text: "Super Admin"
        expect(page).to have_selector ".col-email", text: "superadmin@example.com"
        expect(page).to have_link "Edit"
        expect(page).to have_link "Delete"
      end
    end
  end

  context "when logged in user is not an admin" do
    before(:each){ login_as user }

    scenario "listing, creation and deletion of users is not allowed" do
      visit dashboard_path
      expect(page).to have_no_link "Users"

      visit "/users"
      expect(page).to have_content "You are not authorized"

      visit "/users/new"
      expect(page).to have_content "You are not authorized"

      visit "/users/#{another_user.id}/edit"
      expect(page).to have_content "You are not authorized"

      visit "/users/#{user.id}/edit"
      expect(page).to have_no_content "You are not authorized"
      expect(page).to have_link "Test User"
      expect(page).to have_field "Email", with: "testuser@example.com"
    end
  end

  context "sensors" do
    before(:each){ login_as user }
    scenario "user is able to see his own sensors only" do
      expect(sensor).to be_persisted
      expect(another_sensor).to be_persisted
      visit sensors_path

      expect(page).to have_content "ABCDEFGH"
      expect(page).to have_no_content "STUVWXYZ"

      login_as another_user
      visit sensors_path
      expect(page).to have_content "There are no Sensors yet."
    end
    scenario "user is unable to perform any other actions on sensors" do
      expect{ visit "/sensors/new" }.to raise_error(ActionController::RoutingError)
      expect{ visit "/sensors/#{sensor.id}/edit" }.to raise_error(ActionController::RoutingError)
      expect{
        page.driver.submit :delete, "/sensors/#{sensor.id}", {}
      }.to raise_error(ActionController::RoutingError)
    end
  end

  context "sensor data" do
    before(:each){ login_as user }
    scenario "user is able to see his own sensor data only" do
      expect(sensor_datum).to be_persisted
      expect(another_sensor_datum).to be_persisted
      visit sensor_data_path

      expect(page).to have_content "Sensor ABCDEFGH"
      expect(page).to have_no_content "Sensor STUVWXYZ"

      login_as another_user
      visit sensor_data_path
      expect(page).to have_content "There are no Sensor Data yet."
    end

    scenario "user is unable to perform any other actions on sensor data" do
      expect{ visit "/sensor_data/new" }.to raise_error(ActionController::RoutingError)
      expect{ visit "/sensor_data/#{sensor_datum.id}/edit" }.to raise_error(ActionController::RoutingError)
      expect{
        page.driver.submit :delete, "/sensor_data/#{sensor_datum.id}", {}
      }.to raise_error(ActionController::RoutingError)
    end
  end

  context "aggregates" do
    before(:each){ login_as user }
    scenario "user is able to see his own aggregated data only" do
      expect(aggregate).to be_persisted
      expect(another_aggregate).to be_persisted
      visit aggregates_path

      expect(page).to have_content "Sensor ABCDEFGH"
      expect(page).to have_no_content "Sensor STUVWXYZ"

      login_as another_user
      visit aggregates_path
      expect(page).to have_content "There are no Aggregates yet."
    end

    scenario "user is unable to perform any other actions on aggregated data" do
      expect{ visit "/aggregates/new" }.to raise_error(ActionController::RoutingError)
      expect{ visit "/aggregates/#{aggregate.id}/edit" }.to raise_error(ActionController::RoutingError)
      expect{
        page.driver.submit :delete, "/aggregates/#{aggregate.id}", {}
      }.to raise_error(ActionController::RoutingError)
    end
  end
end
