class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.belongs_to :assistant, index: true
      t.integer :role, default: 0

      t.timestamps
    end
    add_foreign_key :users, :users, column: :assistant_id
  end
end
