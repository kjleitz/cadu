class ReminderPolicy < ApplicationPolicy

  def create?
    user.admin? || record_assistant?
  end

  def dismiss?
    user.admin? || record_client?
  end

  def destroy?
    user.admin? || record_assistant?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
