class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :article, optional: true
  belongs_to :comment, optional: true

  after_create :rating_updated
  after_update :rating_updated

  private
  def rating_updated
    if self.article_id != nil
      @article = Article.find(self.article_id)
      @article.rating_updated
    end
  end
end
