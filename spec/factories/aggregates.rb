FactoryGirl.define do
  factory :minute_aggregate_point, class: Aggregate do
    sensor
    period_start { 1.hour.ago }
    period_end { period_start + 1.minute }
    period_length "minute"
    total { rand(85) + 15 }
    count { rand(5) + 1 }
    mean { total/count.to_f }
    std_dev { rand }

    factory "5-minute_aggregate_point" do
      period_end { period_start + 5.minute }
      period_length "5-minute"
    end

    factory :hour_aggregate_point do
      period_end { period_start + 1.hour }
      period_length "hour"
    end
  end
end
