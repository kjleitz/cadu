class NotificationPolicy < ApplicationPolicy

  def view?
    user.admin? || user == record.receiver
  end

  class Scope < Scope
    def resolve
      if user.client? || user.assistant?
        scope.where(receiver_id: user.id)
      elsif user.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
