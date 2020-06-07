class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def new
    @article = Article.new
  end

  def create
    # Require the top-level key of article and permit title and description
    # from there to create this article instance variable. This whitelisting
    # is necessary due to Rails security feature.
    @article = Article.new(article_params)
    # temporarily hardcode user
    @article.user_id = 6
    if @article.save
      # more verbose way: redirect_to article_path(@article)
      flash[:notice] = "Article created successfully"
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    set_article
  end

  def update
    updated = @article.update(article_params)
    if updated
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
