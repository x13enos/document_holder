json.(document, :id, :name)
json.added document.created_at.strftime("%d %B %Y")
json.box do 
  json.id document.box&.id
  json.name document.box&.name
  json.color document.box&.color
end
json.images document.images do |image|
  json.id image.id
  json.url image.url
  json.name image.filename.to_s
end