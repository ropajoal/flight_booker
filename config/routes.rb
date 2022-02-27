Rails.application.routes.draw do
  get 'bookings', to:'bookings#new'
  post 'bookings', to:'bookings#create'
  get 'bookings/:id', to:'bookings#show'
  post '/checkout/create', to: 'checkout#create'
  get '/flights', to:'flights#index'
  get '/passengers/:id', to:'passengers#confirm_email'
  root 'flights#index'
end
