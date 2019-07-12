class AddHasRepliesToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :has_replies, :boolean, default: false
  end
end
