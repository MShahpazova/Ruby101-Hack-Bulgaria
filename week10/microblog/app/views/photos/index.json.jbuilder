json.array!(@photos) do |photo|
  json.extract! photo, :id, :name, :url
  json.url photo_url(photo, format: :json)
end
