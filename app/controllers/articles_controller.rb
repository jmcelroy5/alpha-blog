class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      # more verbose way: redirect_to article_path(@article)
      flash[:notice] = "Article created successfully"
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
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
    # Require the top-level key of article and permit title and description attributes.
    # This is necessary due to Rails security feature.
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user || !current_user.admin?
      flash[:alert] = "You are unauthorized to access that"
      redirect_to @article
    end
  end
end
