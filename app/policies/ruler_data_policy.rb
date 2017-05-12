class RulerDataPolicy < ApplicationPolicy

  def index?
    true
  end

  def last?
    true
  end

  def show?
    scope.where(:id => record.id).exists? && (record.ruler.device.reservoir.customer == user.customer || user.admin?)
  end

  def create?
    record.ruler&.device&.reservoir&.customer == user.customer || user.admin?
  end

  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      else
        scope.from_customer(user.customer)
      end
    end
  end
end
