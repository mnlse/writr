class AddSlugNameToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :slug_name, :string
  end
end
