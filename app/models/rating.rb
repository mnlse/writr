class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :article

  after_create :rating_updated
  after_update :rating_updated

  private
  def rating_updated
    @article = Article.find(self.article_id)
    @article.rating_updated
  end
end
