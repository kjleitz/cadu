class Task < ApplicationRecord
  belongs_to :client, class: User
  delegate :assistant, to: :client if status > 0
  has_many :notifications
  has_many :comments
  has_many :labels_tasks
  has_many :labels, through: :labels_tasks
end
