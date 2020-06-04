class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # Require the top-level key of article and permit title and description
    # from there to create this article instance variable. This whitelisting
    # is necessary due to Rails security feature.
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      # more verbose way: redirect_to article_path(@article)
      flash[:notice] = "Article created successfully"
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    updated = @article.update(params.require(:article).permit(:title, :description))
    if updated
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end
end
