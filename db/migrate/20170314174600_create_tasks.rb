class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.timestamp :due_date
      t.belongs_to :client, index: true
      t.integer :status, default: 0

      t.timestamps
    end
    add_foreign_key :tasks, :users, column: :client_id
  end
end
