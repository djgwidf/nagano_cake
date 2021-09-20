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

  root 'homes#top'
  get "home/about" => "homes#about"

  resources :customers, only:[:show, :edit, :update]
  get '/customers/:id/quit' => 'customers#quit', as: 'quit_customer'
  patch '/customers/:id/out' => 'customers#out', as: 'out_switch_customer'
  resources :addresses, except: [:new, :show]
  resources :items, only: [:index, :show]
  resources :ship_addresses, except: [:new, :show]
  resources :cart_items, except: [:new, :show, :edit]
  delete '/cart_items' => 'cart_items#destroy_all'
  resources :genres, only: [:index] do
  resources :items, only: [:index]
  resources :orders, except: [:edit, :update, :destroy]
  get '/orders/log' => 'orders#log', as: 'orders_log' #購入確認画面への遷移
  get '/orders/create_order' => 'orders#create_order' #購入確定のアクション
  post '/orders/create_ship_address' => 'orders#create_ship_address'
  
  end
end
