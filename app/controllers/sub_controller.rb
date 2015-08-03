class SubController < ApplicationController

  def about_us

  end

  def business

  end

  def contact

  end

  def news
    @articles = Article.where(category_id: params[:category] || 2).order('id desc').paginate(page: params[:page], per_page: 6)
  end

  def show
    @article = Article.find(params[:id])
  end

end
