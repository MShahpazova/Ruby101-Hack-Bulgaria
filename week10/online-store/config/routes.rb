Rails.application.routes.draw do
  get '/brands', to: 'brands#index'
  post 'brands/new', to: 'brands#create'
  get 'brands/count', to: 'brands#count'
  get 'brands/:id', to: 'brands#show', as: :brand
  get 'brands/range/:id/:count', to: 'brands#count_range'
  get 'brands/range/:id', to: 'brands#range'
  put 'brands/:id/update', to: 'brands#update'
  delete 'brands/:id', to: 'brands#destroy'

  get '/categories', to: 'categories#index'
  post 'categories/new', to: 'categories#create' 
  get 'categories/count', to: 'categories#count'
  get 'categories/:id', to: 'categories#show', as: :category
  get 'categories/range/:id/:count', to: 'categories#count_range'
  get 'categories/range/:id', to: 'categories#range'
  put 'categories/:id', to: 'categories#update'
  delete 'categories/:id', to: 'categories#destroy'
    
  get '/products', to: 'products#index'
  post 'products/new', to: 'products#create'
  get 'products/count', to: 'products#count'
  get 'products/range/:id/:count', to: 'products#count_range'
  get 'products/:id', to: 'categories#show' as: :product
  delete 'products/:id', to: 'products#destroy'
  get 'products/range/:id', to: 'products#range' 
  put 'products/:id/update' to: 'products#update'
  
  get '/search/:type/:slug' to: 'searches#filter'
  # GET /search/{type}/{slug}
end