class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user.admin? || user.id == record.id
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      #if user.admin?
        scope.all
      #else
      #  scope.where(published: true)
      #end
    end
  end

end
