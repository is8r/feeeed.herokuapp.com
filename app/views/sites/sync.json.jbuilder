json.array!(@sites) do |site|
  json.extract! site, :id, :name, :url, :rss
  json.url spredsheet_url(site, format: :json)
end
