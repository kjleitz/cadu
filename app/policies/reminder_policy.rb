class ReminderPolicy < ApplicationPolicy

  def create?
    user.admin? || user == record.assistant
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
