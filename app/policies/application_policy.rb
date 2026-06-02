class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?    = true
  def show?     = same_org?
  def create?   = true
  def update?   = same_org?
  def destroy?  = false

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
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
