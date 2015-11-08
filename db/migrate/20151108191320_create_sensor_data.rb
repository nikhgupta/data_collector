class CreateSensorData < ActiveRecord::Migration
  def change
    create_table :sensor_data do |t|
      t.references :sensor, index: true, foreign_key: true
      t.time :data_time
      t.string :data_value

      t.timestamps null: false
    end
  end
end
