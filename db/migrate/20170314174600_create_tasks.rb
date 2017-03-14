class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.text :content
      t.timestamp :due_date
      t.belongs_to :user, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
