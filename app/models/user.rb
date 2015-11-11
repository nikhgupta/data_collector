class User < ActiveRecord::Base
  has_many :sensors
  has_many :sensor_data, through: :sensors
  has_many :aggregates, through: :sensors

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of   :uuid
  validates_uniqueness_of :uuid, conditions: -> { where(fake: false) }

  scope :fake, -> { where(fake: true) }
  scope :real, -> { where(fake: false) }

  before_save :upcase_uuid

  def name
    attribute %w(name email).detect{|field| attribute(field).present?}
  end

  def self.find_by_uuid(uuid)
    find_by(uuid: uuid.try(:upcase))
  end

  def self.new_with_session(params, session)
    if found = fake.find_by_uuid(params["uuid"])
      found.tap do |resource|
        resource.email = params["email"]
        resource.password = params["password"]
      end
    else
      super.tap do |resource|
        resource.uuid = params["uuid"].try(:upcase)
      end
    end
  end

  private

  def upcase_uuid
    self.uuid = self.uuid.to_s.upcase
  end
end
