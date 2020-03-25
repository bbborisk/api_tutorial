class ArticlesController < ApplicationController

  def index
    articles = Article.recent.page(params[:page]).per(params[:per_page]) # pagination form kaminari gem
    render json: articles
  end

  def show

  end

end
