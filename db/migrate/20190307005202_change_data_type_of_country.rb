class ChangeDataTypeOfCountry < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :country
    add_column :users, :country_id, :integer
  end
end
