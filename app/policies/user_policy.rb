class UserPolicy < ApplicationPolicy

  def index?
    user.admin? || user.assistant?
  end

  def show?
    user.admin? || user == record || user.assistant == record || record_assistant?
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
