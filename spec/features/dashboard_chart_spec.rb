require 'rails_helper'

RSpec.feature "Dashboard Chart", js: true, slow: true do
  scenario "user has no sensors in his account" do
    user = login_as create(:user)

    visit dashboard_path
    expect(page).not_to have_highchart
    expect(page).to have_content "No sensors found for your account"
  end

  scenario "user has no aggregates data collected" do
    user = login_as create(:user)
    sensor = create :sensor, user: user

    visit dashboard_path
    expect(page).not_to have_highchart
    expect(page).to have_no_content "No sensors found for your account"
    expect(page).to have_content "No data points found for your sensors"

    expect(page).to have_selector("form.charts")
    expect(page).to have_select("sensors", with_options: [sensor.uuid])
  end

  scenario "user has sensors and aggregates data to view" do
    aggregate1 = create :minute_aggregate_point, period_start: 3.minute.ago
    aggregate2 = create :minute_aggregate_point, period_start: 1.minute.ago, sensor: aggregate1.sensor
    login_as aggregate1.user

    visit dashboard_path
    expect(page).to have_no_content "No sensors found for your account"
    expect(page).to have_no_content "No data points found for your sensors"
    expect(page).to have_highchart.inside("#sensor-charts .chart").with_data_points(2)

    sensors = [aggregate1.sensor.uuid]
    durations = ["Every Minute", "Every 5 Minute", "Every Hour"]
    expect(page).to have_selector("form.charts")
    expect(page).to have_select("Sensors", with_options: sensors, selected: sensors)
    expect(page).to have_select("Period Length", with_options: durations, selected: durations)

    expect(page).to have_field("period_start", with: aggregate1.period_start.strftime("%Y/%m/%d %H:%M"))
    expect(page).to have_field("period_end", with: aggregate2.period_start.strftime("%Y/%m/%d %H:%M"))
  end
end
