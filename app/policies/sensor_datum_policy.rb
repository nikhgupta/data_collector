class SensorDatumPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(sensor_id: user.sensor_ids)
    end
  end
end
