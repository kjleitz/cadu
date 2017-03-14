class Notification < ApplicationRecord
  belongs_to :task
  delegate :client, to: :task
end
