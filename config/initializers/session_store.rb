if Rails.env === 'production' 
  Rails.application.config.session_store :cookie_store, key: '_document_holder', domain: 'name-of-you-app-json-api'
else
  Rails.application.config.session_store :cookie_store, key: '_document_holderr', expire_after: 8.hours 
end