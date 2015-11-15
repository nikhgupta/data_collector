require 'rails_helper'

RSpec.describe SensorDatum, type: :model do
  it "has a valid string representation" do
    travel_to Time.new(2000, 01, 01, 00, 00, 23, "+00:00")
    sensor = build_stubbed(:sensor, uuid: "ABCD")
    data = build_stubbed(:sensor_datum, sensor: sensor, data_time: Time.now)

    expect(data.to_s).to eq "Sensor ABCD: January 01, 2000 00:00"
  end
end
