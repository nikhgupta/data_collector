require 'rails_helper'

RSpec.describe Sensor, type: :model do
  it "has a valid string representation" do
    sensor = build_stubbed(:sensor, uuid: "ABCD")
    expect(sensor.to_s).to eq "Sensor ABCD"
  end

  it "upcases UUID before saving them in databae" do
    sensor = create :sensor, uuid: "abcd"
    expect(sensor.uuid).to eq "ABCD"
    sensor.update_attribute :uuid, "efgh"
    expect(sensor.uuid).to eq "EFGH"
  end
end
