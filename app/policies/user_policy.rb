class UserPolicy < ApplicationPolicy

  def index?
    user.admin? || user.assistant?
  end

  def show
    user.admin? || user == record || user.assistant == record || record_assistant?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
