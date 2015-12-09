class Crawler::Article::NetEase < Crawler::Article
  def self.get_article_urls
    count = 0
    page_url = 'http://money.163.com/special/00253368/institutions.html'
    Nokogiri::HTML(open(page_url), nil, "GB18030").css(".area .colLM .newsList li").each do |li|
      url = li.css("a").attr("href").to_s rescue nil
      count += 1
      if self.find_by(url: url) or count > 5
        break
      end
      title = li.css("a").text
      self.create(url: url, title: title)
    end
  end

  def get_content
    content = Nokogiri::HTML(open(url),nil,"GB2312").css("#endText p")[0..-2].to_s
    save_article(2 ,content: content, source: '网易财经')
  end
end
