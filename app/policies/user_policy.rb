class UserPolicy < ApplicationPolicy

  def index?
    user unless no_assistant?
  end

  def new?
    !user
  end

  def show?
    (user.admin? || user == record || user.assistant == record || record_assistant?) unless no_assistant?
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
        scope.where(id: user.id).or(scope.where(assistant_id: user.id))
      elsif user.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
