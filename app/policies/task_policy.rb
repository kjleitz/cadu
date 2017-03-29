class TaskPolicy < ApplicationPolicy

  def index?
    user
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
