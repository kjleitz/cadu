class User < ApplicationRecord

  # As general user
  has_many :comments, foreign_key: :author_id

  # As client
  belongs_to :assistant, class_name: User
  has_many :tasks, foreign_key: :client_id
  has_many :reminders, foreign_key: :client_id

  # As assistant
  has_many :clients, foreign_key: :assistant_id

  enum role: [:client, :assistant, :admin]

  # returns nil if not an assistant, array if so
  def client_tasks
    clients.map(&:requested_tasks).flatten if assistant?
  end

  def requested_tasks
    tasks.where(status: 1..3)
    # could use tasks.select(&:requested?) instead, but I'd prefer to use
    # 'where' when I can
  end

end
