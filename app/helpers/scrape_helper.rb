module ScrapeHelper

  require 'parallel'
  require 'nokogiri'
  require 'open-uri'

  # --------------------------------------------------
  # スケジューラーから実行
  # ApplicationController.helpers.scrape_schedule
  def scrape_schedule
    Parallel.each(Site.all, in_threads: 2) {|i|
      scrape i.rss
    }
  end

  # all
  def scrape_all
    sites = Site.all
    sites.each do |i|
      scrape i.rss
    end
  end

  # --------------------------------------------------

  def scrape (uri)
    return '' unless uri

    re = []
    begin
      page = URI.parse(uri).read
      # doc = Nokogiri::XML(open(uri), nil, 'CP932')
      doc = Nokogiri::XML(page, uri, 'utf-8')

      doc.css('item').each do |i|
        # new
        post = Post.new
        post.title = i.xpath('title').text
        post.url = i.xpath('link').text
        post.description = i.xpath('description').text

        post.posted_at = get_time(i)
        post.image_url = get_image_url(i)
        post.site_id = get_site_id_rss(uri)

        # save
        add_db_create(post)

        re.push post
      end

    rescue
    ensure
    end

    delete_empty_url

    re
  end

  # postの時間を取得
  def get_time(i)

    begin
      if i.xpath('pubDate')
        posted_at = Time.parse(i.xpath('pubDate').text)
      end
    rescue
    end
    return posted_at if posted_at

    begin
      if i.xpath('dc:date')
        posted_at = Time.parse(i.xpath('dc:date').text)
      end
    rescue
    end

    return posted_at if posted_at
    return posted_at = Time.mktime(1999, 1, 1, 00, 00, 00)
  end

  # postの画像を取得
  def get_image_url(i)

    begin
      node = Nokogiri::HTML(i.xpath('content:encoded').text)
      image_url = node.search('img').attribute('src').value
    rescue
    end
    return image_url if image_url

    begin
      node = Nokogiri::XML(i.search('content:encoded').text)
      image_url = node.search('img').attribute('src').value
    rescue
    end
    return image_url if image_url

    begin
      node = Nokogiri::HTML(i.xpath('description').text)
      image_url = node.search('img').attribute('src').value
    rescue
    end
    return image_url if image_url

    begin
      node = Nokogiri::XML(i.search('description').text)
      image_url = node.search('img').attribute('src').value
    rescue
    end
    return image_url if image_url

    begin
      image_url = i.search('image').css('url').text
    rescue
    end
    return image_url if image_url

  end

  # postのurlが空のレコードは削除
  def delete_empty_url
    re = []
    posts = Post.where(:url => '')
    posts.each do |i|
      i.destroy
      re.push i
    end
    posts = Post.where("posted_at <= ?", Time.new(2000,1,1))
    posts.each do |i|
      i.destroy
      re.push i
    end
    re
  end

  # rssのurlからsite_idを取得
  def get_site_id_rss(rss)
    site = Site.where(rss: rss).first
    re = 0
    unless site.blank?
      re = site.id
    end
    re
  end

  # dbにpostを追加
  def add_db_create(post)
    posts = Post.where(:url => post.url).first
    if posts.blank?
      if post.save
        rewrite_post_columns(post)
        if post.site_id == 3
          rewrite_post_columns_images(post)
        end
      end
    end
  end

  # --------------------------------------------------

  # rewrite処理
  def rewrite
    re = []
    delete_empty_url

    # 通常 url_originalが無いものをアップデート
    posts = Post.where(:url_original => nil)
    posts.each do |i|
      rewrite_post_columns i
    end

    re
  end

  # 特定のPostをリライト
  def test_rewrite_post(id)
    re = []

    i = Post.find(id)
    re.push rewrite_post_columns(i)

    re
  end

  # 特定のサイトのPostsをリライト
  def test_rewrite_site_posts(id)
    re = []

    posts = Post.where(:site_id => id)
    posts.each do |i|
      rewrite_post_columns_images i
    end

    re
  end

  # 追加情報を上書き
  def rewrite_post_columns(i)
    # サイト情報の詳細ページではなく元サイトのURLを上書き
    url_original = get_original_url(i)
    if url_original.present?
      i.update_columns(url_original: url_original)
    end
    url_original
  end

  # 追加情報を上書き
  def rewrite_post_columns_images(i)
    # FWAはサムネイルが小さいのでFWAのサイトの画像URLで上書き
    image_url = ''
    if i.site_id == 3
      image_url = get_wririte_original_image(i)
      if image_url.present?
        i.update_columns(image_url: image_url)
      end
    end

    image_url
  end

  def get_original_url(post)
    re = ''
    uri = post.url
    site_id = post.site_id

    # Awwwards
    if site_id == 1
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('a.view-site').each do |i|
        href = i.attribute('href').value
        re = href if href.present?
      end
    end

    # CSS Design Awards
    if site_id == 2
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('#wotd-desc-site-name-only a').each do |i|
        href = i.attribute('href').value
        re = href if href.present?
      end
    end

    # FWA
    if site_id == 3
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('#view_site .component_site_item .content .footer .column1 .link a').each do |i|
        href = i.attribute('href').value
        re = href if href.present?
      end
    end

    # One Page Love
    if site_id == 4
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('.review-launch a').each do |i|
        href = i.attribute('href').value
        re = href if href.present?
      end
    end

    # siteInspire
    if site_id == 5
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('#website .preview a').each do |i|
        href = i.attribute('href').value
        re = href if href.present?
      end
    end

    # CSS Awards
    if site_id == 6
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('.jumbotron .container .col-md-6 a').each do |i|
        href = i.attribute('href').value
        re = href if href.present?
      end
    end

    # The Best Designs
    if site_id == 7
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('#container .content .post-image a').each do |i|
        href = i.attribute('href').value
        re = href if href.present?
      end
    end

    # CSSDSGN
    if site_id == 8
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('.post-single .one-half')[0].css('.post a').each do |i|
        href = i.attribute('href').value
        re = href if href.present?
      end
    end

    # Best Website Gallery
    if site_id == 9
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('#content .item')[0].css('.screenshot')[0].css('a').each do |i|
        href = i.attribute('href').value
        re = href if href.present?
      end
    end

    # destroy
    if site_id == 0
      post.destroy
    end

    re
  end
  def get_wririte_original_image(post)
    re = ''
    uri = post.url
    site_id = post.site_id

    # FWA
    if site_id == 3
      page = URI.parse(uri).read
      doc = Nokogiri::HTML(page, uri, 'utf-8')
      doc.css('#view_site .component_site_item .content .slideshow_container .images ul li')[0].css('img').each do |i|
        src = i.attribute('src').value
        re = src if src.present?
      end
    end

    re
  end

  # --------------------------------------------------

end
