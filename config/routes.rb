Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/auth/:provider/callback', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  namespace :pages do
    get '/salerecords/', to: 'sale_records#index'
    post '/salerecords/', to: 'sale_records#upload_file'
  end

  get '/home', to: 'pages#home'

  root to: 'pages#login'
end
