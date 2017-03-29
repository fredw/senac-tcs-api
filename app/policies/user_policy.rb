class UserPolicy < ApplicationPolicy
  attr_reader :user, :resource

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
