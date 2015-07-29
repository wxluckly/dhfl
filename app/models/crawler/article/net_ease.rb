class Crawler::Article::NetEase < Crawler::Article
  def self.get_article_urls
    signal = ""
    1.upto 10 do |page_num|
      if page_num == 1
        page_url = 'http://money.163.com/special/00253368/institutions.html'
      else
        page_url = "http://money.163.com/special/00253368/institutions_0#{page_num}.html"
      end
      Nokogiri::HTML(open(page_url), nil, "GB18030").css(".area .colLM .newsList li").each do |li|
        url = li.css("a").attr("href").to_s rescue nil
        if self.find_by(url: url)
          signal = "break" and break
        end
        title = li.css("a").text
        self.create(url: url, title: title)
      end
      break if signal == 'break'
    end
  end

  def get_content
    content = Nokogiri::HTML(open(url),nil,"GB2312").css("#endText p")[0..-2].to_s
    save_article(2,content: content)
  end
end
