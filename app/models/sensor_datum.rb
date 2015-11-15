class SensorDatum < ActiveRecord::Base
  belongs_to :sensor
  delegate :user, to: :sensor

  def to_s
    "#{sensor}: #{data_time.utc.strftime "%B %d, %Y %H:%M"}"
  end
end
