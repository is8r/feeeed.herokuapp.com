class TopController < ApplicationController
  def index
    @posts = Post.order(posted_at: :desc).page params[:page]
    @sites = Site.order(name: :asc).all
  end
end
