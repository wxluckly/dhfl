class CrawlerNeteaseJob < ActiveJob::Base
  queue_as :default

  def perform
    Crawler::Article::NetEase.get_article_urls
    # Crawler::Article::NetEase.where(article_id: nil).each {|a| a.get_content}
  end


end
