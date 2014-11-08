json.array!(@sites) do |site|
  json.extract! site, :id, :name, :url, :rss, :active
  json.url site_url(site, format: :json)
end
