class AddIsDraftToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :is_draft, :boolean
  end
end
