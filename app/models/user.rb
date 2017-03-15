class User < ApplicationRecord

  # As client
  belongs_to :assistant, class_name: User, optional: true
  has_many :tasks, foreign_key: :client_id
  has_many :reminders, foreign_key: :client_id

  # As assistant
  has_many :clients, foreign_key: :assistant_id

  # As general user
  has_many :comments, foreign_key: :author_id
  has_many :notifications, foreign_key: :receiver_id

  has_secure_password
  validates :name, :email, :role, presence: true

  enum role: [:client, :assistant, :admin]

  # Assembles all of an assistant's "to-do" tasks (those
  # requested of her by her clients)
  def client_tasks
    clients.map(&:requested_tasks).flatten
  end

  # Scopes tasks which have, at some point, been requested
  # of a client's assistant and have not yet been completed
  def delegated_tasks
    tasks.where(status: 1..3)
  end

  def notify(task, message=nil)
    notifications.create(
      task: task,
      content: message || "#{task.title} needs your attention."
    )
  end

end
