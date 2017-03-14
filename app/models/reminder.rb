class Reminder < ApplicationRecord
  belongs_to :client, class: User
  delegate :assistant, to: :client
end
