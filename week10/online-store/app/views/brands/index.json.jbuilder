json.array!(@brands) do |brand|
  json.extract! brand, :name
  json.url post_url(post, format: :json)
end
