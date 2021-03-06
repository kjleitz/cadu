class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.text :content
      t.belongs_to :task, foreign_key: true
      t.belongs_to :receiver, index: true
      t.integer :status, default: 0

      t.timestamps
    end
    add_foreign_key :notifications, :users, column: :receiver_id
  end
end
