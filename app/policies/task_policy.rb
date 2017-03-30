class TaskPolicy < ApplicationPolicy

  def index?
    user
  end

  def show?
    record_client? || record_assistant?
  end

  def create?
    user.admin? || (user.client? && record_client?)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def request_assistance?
    record_client?
  end

  def accept?
    record_assistant?
  end

  def start?
    record_assistant?
  end

  def mark_complete?
    record_client? || record_assistant?
  end

  class Scope < Scope
    def resolve
      if user.client?
        scope.where(client_id: user.id)
      elsif user.assistant?
        scope.joins(:client).where(users: {assistant_id: user.id}, status: 1..3)
      elsif user.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
