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
end
