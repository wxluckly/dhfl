class Admin::ArticlesController < Admin::BaseController
  def index
    @articles = Article.order("created_at desc").where(category_id: params[:category_id] || 1).paginate(page: params[:page], per_page: 25)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to admin_articles_path
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to admin_articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to admin_articles_path
    else
      redirect_to @article
    end
  end

  def crawler
    Crawler::Article::NetEase.get_article_urls
    Crawler::Article::ChinaVenture.get_article_urls
    Crawler::Article::Flleasing.get_article_urls
    Crawler::Article.where(article_id: nil).each {|a| a.get_content}
    redirect_to :back
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :source, :category_id)
  end
end
