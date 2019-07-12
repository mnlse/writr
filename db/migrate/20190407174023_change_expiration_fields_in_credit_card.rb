class ChangeExpirationFieldsInCreditCard < ActiveRecord::Migration[5.2]
  def change
    change_table :credit_cards do |t|
      t.integer :expiry_month, limit: 1
      t.integer :expiry_year, limit: 2
    end

    remove_column :credit_cards, :expiration_date
  end
end
