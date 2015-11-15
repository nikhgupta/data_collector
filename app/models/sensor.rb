class Sensor < ActiveRecord::Base
  belongs_to :user
  has_many :sensor_data
  has_many :aggregates

  before_save :upcase_uuid

  def to_s
    "Sensor #{uuid}"
  end

  private

  def upcase_uuid
    self.uuid = self.uuid.upcase
  end
end
