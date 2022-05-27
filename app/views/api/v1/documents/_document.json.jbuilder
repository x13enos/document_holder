json.(document, :id, :name)
json.images document.images do |image|
  json.url image.url
  json.name image.filename.to_s
end