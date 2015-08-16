module CleanHtml
  extend ActiveSupport::Concern
  include ActionView::Helpers::SanitizeHelper

  def clean_html content
    doc = Nokogiri::HTML(content)
    doc.search("img").each{|i| i.set_attribute('class', nil)}
    doc.search("img").each{|i| i.set_attribute('style', nil)}
    doc.search("table").each{|i| i.set_attribute('class', nil)}
    doc.search("table").each{|i| i.set_attribute('border', 1)}
    doc.search("table").each{|i| i.set_attribute('style', nil)}
    doc.search("table").each{|i| i.set_attribute('cellspacing', 0)}
    doc.search("td").each{|i| i.set_attribute('style', nil)}
    str = doc.to_s
    str = str.encode('utf-8')
    str = strip_links str
    str = rm_tag str
    str = join_html_str str
    str
  end

  def clean_user content
    doc = Nokogiri::HTML(content)
    # 放置集体处理的内容
    doc.search("img").each{|i| i.set_attribute('class', nil)}
    doc.search("img").each{|i| i.set_attribute('style', nil)}
    doc.search("table").each{|i| i.set_attribute('class', nil)}
    doc.search("table").each{|i| i.set_attribute('border', 1)}
    doc.search("table").each{|i| i.set_attribute('style', nil)}
    doc.search("table").each{|i| i.set_attribute('cellspacing', 0)}
    str = doc.to_s
    str = str.encode('utf-8')
    str = strip_links str
    str = rm_tag str, {span: true}
    str = join_user_str str
    str
  end

  private

  def rm_tag str, **option
    # 去除script等不安全标签
    str = Loofah.fragment(str).scrub!(:prune).to_s
    str.gsub!(%r{<span[^>]*>}   , "") if option[:span].blank?
    str.gsub!(%r{</span>}       , "") if option[:span].blank?
    str.gsub!(%r{<strong[^>]*>} , "")
    str.gsub!(%r{</strong>}     , "")
    str.gsub!(%r{<font[^>]*>}   , "")
    str.gsub!(%r{</font>}       , "")
    str.gsub!(%r{<u[^>]*>}      , "")
    str.gsub!(%r{</u>}          , "")
    str.gsub!(%r{<b[^>]*>}      , "")
    str.gsub!(%r{</b>}          , "")
    str.gsub!(%r{ }             , "")
    str.gsub!(%r{<br[^>]*>}     , "\n")
    # str.gsub!(%r{<\/[^>]*>}     , "\n")
    str.gsub!(%r{<p[^>]*>}      , "\n")
    str.gsub!(%r{</p>}          , "\n")
    str.gsub!(%r{<div[^>]*>}    , "\n")
    str.gsub!(%r{</div>}        , "\n")
    str.gsub!(%r{<li[^>]*>}     , "\n")
    str.gsub!(%r{</li>}         , "\n")
    str.gsub!(%r{<ul[^>]*>}     , "\n")
    str.gsub!(%r{</ul>}         , "\n")
    str.gsub!(%r{<h1[^>]*>}     , "\n")
    str.gsub!(%r{</h1>}         , "\n")
    str.gsub!(%r{<h2[^>]*>}     , "\n")
    str.gsub!(%r{</h2>}         , "\n")
    str.gsub!(%r{<h3[^>]*>}     , "\n")
    str.gsub!(%r{</h3>}         , "\n")
    str.gsub!(%r{<h4[^>]*>}     , "\n")
    str.gsub!(%r{</h4>}         , "\n")
    str.gsub!(%r{<h5[^>]*>}     , "\n")
    str.gsub!(%r{</h5>}         , "\n")
    str.gsub!(%r{<input[^>]*>}  , "\n")
    str.gsub!(%r{　}            , "\n")
    str.gsub!(%r{\n+}           , "\n")
    str
  end

  def join_html_str str
    result = ""
    str.split("\n").each do |line|
      next if line.blank?
      if line.scan(%r{<[^>]*>}).any?
        result += line.strip
      elsif line.scan(%r{[，,。.：:“”"、；;]}).any?
        result += "<p>#{line.strip}</p>"
      else
        result += "<h5>#{line.strip}</h5>"
      end
    end
    result
  end

  def join_user_str str
    result = ""
    str.split("\n").each do |line|
      next if line.blank?
      if line.scan(%r{<t[^>]*>}).any? || line.scan(%r{<\/t[^>]*>}).any?
        # 如果本行含有table、tr、td、tbody，则不增加p标签包裹
        result += line.strip
      else
        result += "<p>#{line.strip}</p>"
      end
    end
    result
  end

end
