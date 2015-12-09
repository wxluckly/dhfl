class Crawler::Article < ActiveRecord::Base
  validates :url, presence: true, uniqueness: { scope: :type }
  self.table_name = "crawler_articles"

  belongs_to :article, class_name: "::Article"
  def save_article(category, **data)
    content = data[:content] || ""
    if self.article_id
      article = ::Article.find(self.article_id)
      article.update(title: title, content: content, category_id: category, source: data[:source])
    else
      article = self.create_article(title: title, content: content, category_id: category, source: data[:source])
      self.article = article
      self.save
    end
  end
end
