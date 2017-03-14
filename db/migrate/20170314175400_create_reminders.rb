class CreateReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :reminders do |t|
      t.text :content
      t.belongs_to :user, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
