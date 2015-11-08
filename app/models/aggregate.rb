class Aggregate < ActiveRecord::Base
  belongs_to :sensor

  def to_s
    "#{sensor}: #{period_length}: #{period_start}-#{period_end}"
  end
end
