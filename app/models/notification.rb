class Notification < ApplicationRecord
  belongs_to :task
  belongs_to :receiver, class_name: User

  enum status: [:unseen, :seen, :dismissed]

  def view
    seen!
  end

  def dismiss
    dismissed!
  end
end
