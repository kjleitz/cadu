class Task < ApplicationRecord
  belongs_to :client, class: User
  delegate :assistant, to: :client
  has_many :notifications
  has_many :comments
  has_many :labels, through: :labels_tasks
end
