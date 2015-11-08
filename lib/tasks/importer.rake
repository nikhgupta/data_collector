namespace :importer do
  desc 'Import Customers from CSV file inside ./data'
  task customer: :environment do
    # data = CSV.read Rails.root.join("data", "customer.csv")
    # User = ``
  end

  desc 'Import Sensors from CSV file inside ./data'
  task sensors: :environment do
    CSV.foreach(Rails.root.join("data", "sensors.csv").to_s) do |row|
      sensor = Sensor.find_or_initialize_by(uuid: row[2])
      sensor.update_attributes(user_id: row[1], format: row[3], length: row[4])
    end
  end

  desc 'Import Sensor data from CSV file inside ./data'
  task sensor_data: :environment do
    CSV.foreach(Rails.root.join("data", "sensor_data.csv").to_s) do |row|
      sensor_data = SensorDatum.find_or_initialize_by(sensor_id: row[1], data_time: row[2])
      sensor_data.update_attributes(data_value: row[3])
    end
  end

  desc 'Import aggregate data from CSV file inside ./data'
  task aggregates: :environment do
    CSV.foreach Rails.root.join("data", "aggregates.csv").to_s do |row|
      aggregate = Aggregate.find_or_initialize_by(sensor_id: row[1], period_start: row[2], period_end: row[3])
      aggregate.update_attributes(
        period_length: row[4], total: row[5], count: row[6],
        mean:  row[7], std_dev: row[8]
      )
    end
  end
end

importer_tasks = %w(customer sensors sensor_data aggregates).map{|task| "importer:#{task}"}
task import: importer_tasks
