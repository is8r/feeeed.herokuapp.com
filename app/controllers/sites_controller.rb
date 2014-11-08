class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with :name => ENV["BASIC_KEY"], :password => ENV["BASIC_PW"] if Rails.env.production?
  respond_to :html, :json

  def index
    @sites = Site.order(:created_at).page params[:page]
    respond_with(@sites)
  end

  def sync
    Site.sync_with_site_rows
    @sites = Site.all
    respond_to do |format|
      format.json { render :json => @sites }
    end
  end

  def show
    respond_with(@site)
  end

  def new
    @site = Site.new
    respond_with(@site)
  end

  def edit
  end

  def create
    @site = Site.new(site_params)
    @site.save
    respond_with(@site)
  end

  def update
    @site.update(site_params)
    respond_with(@site)
  end

  def destroy
    @site.destroy
    respond_with(@site)
  end

  private
    def set_site
      @site = Site.find(params[:id])
    end

    def site_params
      params.require(:site).permit(:name, :url, :rss, :active)
    end
end
