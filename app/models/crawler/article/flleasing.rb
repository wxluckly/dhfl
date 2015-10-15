class Crawler::Article::Flleasing < Crawler::Article
  def self.get_article_urls
    count = 0
    page_url = 'http://www.flleasing.com/class.asp?classid=1'
    Nokogiri::HTML(open(page_url), nil, "GB2312").css(".newsBg li").each do |li|
      url = "http://www.flleasing.com/" + li.css("a").attr("href").to_s rescue nil
      count += 1
      if self.find_by(url: url) or count > 5
        break
      end
      title = li.css("a").text
      self.create(url: url, title: title)
    end
  end

  def get_content
    content = Nokogiri::HTML(open(url),nil,"GB2312").css(".NewsContent").to_s
    if Nokogiri::HTML(open(url),nil,"GB2312").css("#BodyLabel p a").present?
      Nokogiri::HTML(open(url),nil,"GB2312").css("#BodyLabel p a").each do |a|
        content << Nokogiri::HTML(open("http://www.flleasing.com/onews.asp#{a.attr('href')}"),nil,"GB2312").css(".NewsContent").to_s
      end
    end
    save_article(2 ,content: content)
  end
end
