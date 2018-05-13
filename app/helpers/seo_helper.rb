module SeoHelper

  def set_display_meta_tags

    #title
    title = Settings.site.title
    og_image = Settings.site.meta.og.image
    url = request.url
    if @set_title
      set_meta_tags :site => @set_title + ' - ' + title
      set_meta_tags :og => {:title => @set_title + ' - ' + title, :type => 'website', :url => url, :image => og_image}
    else
      set_meta_tags :site => title
      set_meta_tags :og => {:title => title, :type => 'website', :url => url, :image => og_image}
    end

    #description
    if @set_meta_description
      set_meta_tags :description => @set_meta_description + ' | ' + Settings.site.meta.description
      set_meta_tags :og => {:description => @set_meta_description + ' | ' + Settings.site.meta.description}
    else
      set_meta_tags :description => Settings.site.meta.description
      set_meta_tags :og => {:description => Settings.site.meta.description}
    end

    #keyword
    if @set_meta_keyword
      set_meta_tags :keyword => @set_meta_keyword + ',' + Settings.site.meta.keywords + ',' + title
    else
      set_meta_tags :keyword => Settings.site.meta.keywords + ', ' + title
    end

    # set_meta_tags :fb => {:admins => Settings.site.meta.og.app_id}
    set_meta_tags :fb => {:app_id => Settings.site.meta.og.app_id}
    set_meta_tags :canonical => request.url
    set_meta_tags :og => {:url => request.url}

    display_meta_tags
  end

end
