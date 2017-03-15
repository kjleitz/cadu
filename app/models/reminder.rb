class Reminder < ApplicationRecord
  belongs_to :client, class_name: User
  delegate :assistant, to: :client
  belongs_to :task, optional: true

  enum status: [:unseen, :seen, :dismissed]

end
