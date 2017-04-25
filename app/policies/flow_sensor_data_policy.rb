class FlowSensorDataPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists? && (record.flow_sensor.device.reservoir.customer == user.customer || user.admin?)
  end

  def create?
    record.flow_sensor&.device&.reservoir&.customer == user.customer || user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
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
