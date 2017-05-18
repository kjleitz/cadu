class User < ApplicationRecord

  # As client
  belongs_to :assistant, class_name: User, optional: true
  has_many :tasks, foreign_key: :client_id
  has_many :reminders, foreign_key: :client_id
  # added in for the spec.md, just for show
  has_many :labels, through: :tasks

  # As assistant
  has_many :clients, foreign_key: :assistant_id, class_name: User

  # As general user
  has_many :comments, foreign_key: :author_id
  has_many :notifications, foreign_key: :receiver_id

  has_secure_password
  validates :name, :role, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: [:client, :assistant, :admin]

  scope :alphabetical, -> { order(:name) }

  after_create :set_role

  # Assembles all of an assistant's "to-do" tasks (those
  # requested of her by her clients)
  def client_tasks
    Task.joins(:client).where(users: {assistant_id: id}, status: 1..3)
  end

  def client_reminders
    Reminder.joins(:client).where(users: {assistant_id: id})
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

  def set_role
    roles = YAML.load_file(Rails.root.join('config', 'roles.yml'))
    self.role = roles[email] if roles[email]
    save
  end

  def provider_name
    provider.humanize.split.first.capitalize
  end

  def avatar_url
    color = Random.new(id).rand(16**5...16**6).to_s(16)
    "https://placehold.it/75x75/#{color}"
  end

  class << self

    def from_omniauth(auth)
      where(
        provider: auth['provider'],
        uid:      auth['uid']
      ).first_or_initialize(
        name:     auth['info']['name'],
        email:    auth['info']['email'],
        password: SecureRandom.base64(10)
      )
    end

  end

end
