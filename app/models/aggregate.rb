class Aggregate < ActiveRecord::Base
  belongs_to :sensor
  delegate :user, to: :sensor

  def to_s
    period_end   = self.period_end.utc.strftime   "%B %d, %Y %H:%M"
    period_start = self.period_start.utc.strftime "%B %d, %Y %H:%M"
    "#{sensor}: #{period_length}: #{period_start} - #{period_end}"
  end
end
