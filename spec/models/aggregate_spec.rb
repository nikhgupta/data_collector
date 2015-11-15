require 'rails_helper'

RSpec.describe Aggregate, type: :model do
  it "has a valid string representation" do
    travel_to Time.new(2000, 01, 01, 00, 00, 23, "+00:00")
    sensor = build_stubbed(:sensor, uuid: "ABCD")
    aggregate = build_stubbed(:minute_aggregate_point, sensor: sensor, period_start: Time.now)
    expect(aggregate.to_s).to eq "Sensor ABCD: minute: January 01, 2000 00:00 - January 01, 2000 00:01"
  end
end
