class Crawler::Article::ChinaVenture < Crawler::Article
  def self.get_article_urls
    count = 0
    page_url = 'http://www.chinaventure.com.cn/'
    Nokogiri::HTML(open(page_url), nil, "GB18030").css(".list01 li").each do |li|
      url = li.css("a").attr("href").to_s rescue nil
      count += 1
      if self.find_by(url: url) or count >= 5
        break
      end
      title = li.css("a").text
      self.create(url: url, title: title)
    end
  end

  def get_content
    content = Nokogiri::HTML(open(url),nil,"GB18030").css(".articon p").to_s
    save_article(2 ,content: content) if content.present?
  end
end
