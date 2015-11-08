class ActiveAdmin::PagePolicy < ApplicationPolicy
  def show?
    case record.name
    when 'Dashboard'
      true
    else
      false
    end
  end
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope
    end
  end
end
