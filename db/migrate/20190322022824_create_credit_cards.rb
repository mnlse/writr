class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :cvv
      t.string :number
      t.date :expiration_date
      t.string :holder_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
