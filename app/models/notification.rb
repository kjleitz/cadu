class Notification < ApplicationRecord
  belongs_to :task
  delegate :client, to: :task

  enum status: [:unseen, :seen, :dismissed]
  
end
