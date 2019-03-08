class AddLocationToUser < ActiveRecord::Migration[5.2]
  def change

    change_table :users do |t|
      t.string :country
      t.string :state
      t.string :city
    end

  end
end
