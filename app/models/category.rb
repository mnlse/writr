class Category < ApplicationRecord
  has_many :articles
  before_create :create_slug_name

  private
  def create_slug_name
    self.slug_name = self.name.downcase
  end
end
