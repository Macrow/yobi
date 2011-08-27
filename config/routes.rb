Yobi::Application.routes.draw do
  resources :products, :only => [:show] do
    resources :comments, :only => [:create]
  end
  resources :categories, :only => [:show] do
    member do
      get 'page/:page', :action => :show
      get 'search', :action => :search      
    end
  end
  resources :articles, :only => [:show]
  devise_for :users
  get "/my_account" => "users#show", :as => "my_account"
  get "/search" => "home#search"
  get "/sitemap" => "home#sitemap"
  get "static/:page_url" => "staticpages#show", :as => :static_page
  root :to => "home#index"

  namespace :admin do
    resources :menus
    resources :articles
    resources :categories
    resources :staticpages
    resources :plists, :except => [:new, :show]
    resources :products do
      resources :images, :only => [:create, :update, :destroy]
      resources :comments, :only => [:index, :edit, :update, :destroy] do
        get "destory_all", :on => :collection
      end
    end
    resources :users do
      resources :comments, :only => [:index, :edit, :update, :destroy] do
        get "destory_all", :on => :collection
      end
      get "admins", :on => :collection
    end
    match "/settings" => "settings#index"
    match "/generate_sitemap" => "settings#generate_sitemap"
    resources :dimages, :only => [:index, :create, :destroy]
    root :to => "home#index"
  end  
  
  get "*path" => "redirect#index"
end

