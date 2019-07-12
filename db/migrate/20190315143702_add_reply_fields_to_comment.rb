class AddReplyFieldsToComment < ActiveRecord::Migration[5.2]
  def change
    change_table :comments do |t|
      t.boolean :is_reply, default: false
      t.integer :reply_to_id
    end
  end
end
