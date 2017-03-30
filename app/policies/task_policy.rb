class TaskPolicy < ApplicationPolicy

  def index?
    user
  end

  def show?
    user.admin? || user == record.client || user == record.assistant
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
    user.admin? || user == record.client
  end

  def accept?
    user.admin? || user == record.assistant
  end

  def start?
    accept?
  end

  def mark_complete?
    request_assistance? || accept?
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
