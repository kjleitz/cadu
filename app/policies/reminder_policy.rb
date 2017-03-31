class ReminderPolicy < ApplicationPolicy

  def create?
    if record.task && !(record.client == record.task.client)
      false
    else
      user.admin? || record_assistant?
    end
  end

  def dismiss?
    user.admin? || record_client?
  end

  def destroy?
    user.admin? || record_assistant?
  end

  class Scope < Scope
    def resolve
      if user.client?
        scope.where(client_id: user.id)
      elsif user.assistant?
        scope.joins(:client).where(users: {assistant_id: user.id})
      elsif user.admin?
        scope
      else
        scope.none
      end
    end
  end
end
