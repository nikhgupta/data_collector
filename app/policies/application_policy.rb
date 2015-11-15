class ApplicationPolicy
  attr_accessor :user, :record

  def initialize(user, record)
    @user, @record = user, record
  end

  def index?
    true
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def destroy_all?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_accessor :user, :scope

    def initialize(user, scope)
      @user, @scope = user, scope
    end

    def resolve
      scope
    end
  end
end
