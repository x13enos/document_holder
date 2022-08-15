#config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do 
  allow do
    origins 'http://localhost:3000'
  
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
  allow do
    origins "document-holder.andres-sild.com"
    resource "*",
             headers: :any,
             credentials: true,
             methods: %i[get post options put patch delete]
  end
end