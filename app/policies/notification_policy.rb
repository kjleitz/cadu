class NotificationPolicy < ApplicationPolicy

  def view?
    user.admin? || user == record.receiver
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
