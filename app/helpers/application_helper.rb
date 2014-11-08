module ApplicationHelper
  include SeoHelper
  include ScrapeHelper
  include ScrapeHelper

  # ApplicationController.helpers.foo_time Time.now
  def foo_time(datetime)
    time_ago_in_words(datetime) + '前'
  end

  def get_posts_count
    count = Post.all.count
    html = '<span class="count">(' + count.to_s + 'posts)</span>'
    raw html
  end

end
