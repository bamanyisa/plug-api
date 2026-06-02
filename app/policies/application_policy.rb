class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    same_org?
  end

  def create?
    true
  end

  def update?
    same_org?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(organization_id: user.organization_id)
    end
  end

  private

  def same_org?
    !record.respond_to?(:organization_id) || record.organization_id == user.organization_id
  end
end
