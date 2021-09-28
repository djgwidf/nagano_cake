Rails.application.routes.draw do

   devise_for :customers, controllers: {
   sessions: 'customers/sessions',
   passwords: 'customers/passwords',
   registrations: 'customers/registrations'
   }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    root 'homes#top'
    resources :genres, only:[:index,:create,:update,:edit]
    resources :items, except: [:destroy]
    resources :customers, only: [:show,:index,:update,:edit]
    resources :orders, only: [:index, :show]
  end

  root 'home#top'
  get "home/about" => "homes#about"

  get '/customers/:id/quit' => 'customers#quit', as: 'quit_customer'
  patch '/customers/:id/out' => 'customers#out', as: 'out_customer'
  resources :customers, only:[:show, :edit, :update]
  resources :addresses, except: [:new, :show]
  resources :items, only: [:index, :show]
  delete '/cart_items' => 'cart_items#destroy_all'
  resources :cart_items, except: [:new, :show, :edit]

  get '/orders/log' => 'orders#log', as: 'orders_log'
  post '/orders/log' => 'orders#log'
  get '/orders/thankx' => 'orders#thankx'
  resources :orders, except: [:edit, :update, :destroy]

  resources :genres, only: [:index] do
  resources :items, only: [:index]
  end
end
