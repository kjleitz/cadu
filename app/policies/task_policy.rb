class TaskPolicy < ApplicationPolicy

  def index?
    user
  end

  def show?
    is_client? || is_assistant?
  end

  def create?
    user.admin? || (user.client? && user == record.client)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def request_assistance?
    is_client?
  end

  def accept?
    is_assistant?
  end

  def start?
    is_assistant?
  end

  def mark_complete?
    is_client? || is_assistant?
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
