class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with :name => ENV["BASIC_KEY"], :password => ENV["BASIC_PW"] if Rails.env.production?
  respond_to :html, :json

  def index
    @posts = Post.order(posted_at: :desc).page params[:page]
    respond_with(@posts)
  end

  def scrape

    # @items = ApplicationController.helpers.test_scraping
    # @items = ApplicationController.helpers.scrape 'http://feeds.feedburner.com/awwwards'
    # @items = ApplicationController.helpers.scrape 'http://bestwebsite.gallery/feed/'

    @items = ApplicationController.helpers.scrape_schedule

    respond_to do |format|
      format.json { render :json => @items }
    end
  end

  def rewrite

    # Postをチェックして足りない項目をscrapeしたりいらないクエリを削除したり
    # @items = ApplicationController.helpers.rewrite
    @items = ApplicationController.helpers.test_rewrite_site_posts(4)

    respond_to do |format|
      format.json { render :json => @items }
    end
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.save
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :url, :posted_at, :image_url, :url_original)
    end
end
