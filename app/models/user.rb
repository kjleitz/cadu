class User < ApplicationRecord

  # As general user
  has_many :comments, foreign_key: :author_id

  # As client
  belongs_to :assistant, class: User
  has_many :tasks, foreign_key: :client_id
  has_many :reminders, foreign_key: :client_id

  # As assistant
  has_many :clients, foreign_key: :assistant_id

  enum role: [:client, :assistant, :admin]

  def client_tasks
    clients.map(&:requested_tasks).flatten
  end

end
