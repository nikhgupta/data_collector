FactoryGirl.define do
  factory :sensor_datum do
    sensor
    data_time { 1.minute.ago }
    data_value 0
  end
end
