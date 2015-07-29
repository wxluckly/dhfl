class Admin::ArticlesController < Admin::BaseController
  def index
    @articles = Article.where(category_id: params[:category_id] || 1).paginate(page: params[:page], per_page: 1)
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
    if @article.save
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

  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :source, :category_id)
  end
end
