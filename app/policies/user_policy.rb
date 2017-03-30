class UserPolicy < ApplicationPolicy

  def index?
    user.admin? || user.assistant?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
