class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change

    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :is_premium
      t.string :privilege
      t.decimal :account_balance, :precision => 8, :scale => 2
      t.text :bio, :limit => 400
    end

  end
end
