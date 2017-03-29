class CommentPolicy < ApplicationPolicy

  def create
    user.admin? || user == record.task.client || user == record.task.assistant && record.task.delegated?
  end

  def destroy
    user.admin? || user == record.author
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
