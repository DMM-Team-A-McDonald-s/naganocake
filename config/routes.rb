Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  
  scope module: :public do
    root to: "homes#top"
    get "home/about"=>"homes#about"
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    get "customers/unsubscribe"=>"customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :orders, only: [:new, :create, :index, :show]
    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :orders_details, only: [:update]
  end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
