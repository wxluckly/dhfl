class Admin::ArticlesController < Admin::BaseController
  def index
    @articles = Article.all.page params[:page]
  end
end
