module StringHelper


  def link_to_site_id(id)
    html = ''
    site = Site.where(id: id).first
    if site
      url = main_app.sites_path + "/" + site.id.to_s
      html = '<a href="'+url+'">'+site.name+'</a>'
    end
    raw html
  end

  def link_to_site(id)
    html = ''
    site = Site.where(id: id).first
    if site
      html = '<a href="'+site.url+'" target="_blank">['+site.name+']</a>'
    end
    raw html
  end



  # def links_categories()
  #   html = ''
  #   category = Category.all
  #   category.each do |i|
  #     html += '<li>'
  #     html += '<a href="/#/category/' + i.id.to_s + '">'
  #     html += i.name
  #     html += '</a>'
  #     html += '</li>'
  #   end
  #   raw html
  # end

  # def link_to_site_id_to_category(id)
  #   html = ''
  #   site = Site.where(id: id).first
  #   if site
  #     html = link_to_category_id site.category_id
  #   end
  #   raw html
  # end

  # def link_to_category_id(id)
  #   html = ''
  #   category = Category.where(id: id).first
  #   if category
  #     url = main_app.categories_path + "/" + category.id.to_s
  #     html = '<a href="'+url+'">'+category.name+'</a>'
  #   end
  #   raw html
  # end

  # def link_to_post_id(id)
  #   html = ''
  #   post = Post.where(id: id).first
  #   if post
  #     url = main_app.posts_path + "/" + post.id.to_s
  #     html = '<a href="'+url+'">'+post.title+'</a>'
  #     html += '<a href="'+post.url+'" target="_blank"> [link]</a>'
  #   end
  #   raw html
  # end

  # def link_to_image(url, image_url)
  #   if image_url
  #     html = '<a href="'+url+'" class="js-thumbfit">'+'<img src="'+image_url+'" />'+'</a>'
  #   else
  #     html = '<a href="'+url+'" class="noimage">noimage</a>'
  #   end
  #   raw html
  # end


  # def link_to_site_id_feed(id)
  #   site = Site.where(id: id).first
  #   html = '<a href="'+site.url+'" target="_blank">'+site.name+'</a>'
  #   # html += ' <a href="'+site.rss+'" target="_blank">[rss]</a>'
  #   raw html
  # end

end
