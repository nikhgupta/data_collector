module ApiHelper
  def chart_data_for(kind)
    json = JSON.parse response.body
    json["data"].detect do |matrix|
      matrix["name"] == "#{kind.to_s.titleize} Aggregate"
    end.try(:[], "data")
  end

  def create_datasets_for(user, points: 10)
    travel_to Time.new(2000, 01, 01, 00, points, 33, "+00:00") do
      sensors = 5.times.map{ create :sensor, user: user }
      sensors.push create_list(:sensor, 5)
      sensors = sensors.flatten

      durations = {"minute" => 1, "5-minute" => 5, "hour" => 60}
      data = points.times.map do |i|
        (2+rand(3)).times.map do |j|
          durations.each do |kind, val|
            sensor = sensors.sample
            point  = create "#{kind}_aggregate_point",
              total: (points - i)*(sensor.id)*(sensor.user.id)*val,
              count: sensor.id, sensor: sensor, period_start: i.minutes.ago
          end
        end
      end
    end
  end
end
