class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :task, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.boolean :pinned, default: false
      t.boolean :edited, default: false
      # `:edited` may not be super necessary; there are already timestamps
      # which include `updated_at` that I could compare with `created_at` to
      # determine whether or not it has been updated... but maybe some feature
      # will be added later which requires modifying the comment without
      # actually editing the content, which would throw screw that strategy.

      t.timestamps
    end
  end
end
