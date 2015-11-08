class Sensor < ActiveRecord::Base
  belongs_to :user
  has_many :sensor_data
  has_many :aggregates

  before_save :upcase_uuid

  def self.find_by_uuid(uuid)
    find_by(uuid: uuid.try(:upcase))
  end

  def self.find_or_initialize_by_uuid(uuid)
    find_or_initialize_by(uuid: uuid.try(:upcase))
  end

  def to_s
    "Sensor #{uuid}"
  end

  private

  def upcase_uuid
    self.uuid = self.uuid.upcase
  end
end
