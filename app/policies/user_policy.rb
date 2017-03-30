class UserPolicy < ApplicationPolicy

  def index?
    user
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
      if user.client?
        scope.where(id: [user.id, user.assistant_id])
      elsif user.assistant?
        scope.where(id: a.id).or(scope.where(assistant_id: a.id))
      elsif user.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
