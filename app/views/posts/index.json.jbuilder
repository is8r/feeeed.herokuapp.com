json.array!(@posts) do |post|
  json.extract! post, :id, :title, :description, :url, :posted_at, :image_url
  json.url post_url(post, format: :json)
end
