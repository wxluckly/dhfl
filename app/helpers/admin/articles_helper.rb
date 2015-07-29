module Admin::ArticlesHelper
  def category_list
    d = {}
    Category.all.each do |c|
      d[c.name] = c.id
    end
    d
  end
end
