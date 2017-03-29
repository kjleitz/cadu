class Label < ApplicationRecord
  has_many :labels_tasks
  has_many :tasks, through: :labels_tasks

  validates :name, presence: true, uniqueness: true
end
