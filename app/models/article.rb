# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text(65535)
#  author      :string(255)
#  source      :string(255)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Article < ActiveRecord::Base
  include CleanHtml

  belongs_to :category
  has_one :crawler_article, class_name: "Crawler::Article"

  after_create :set_font

  def set_font
    self.update(content: (clean_html content))
  end

end
