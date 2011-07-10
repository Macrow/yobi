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
  match "/search" => "home#search"
  match "/sitemap" => "home#sitemap"
  root :to => "home#index"

  namespace :admin do
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
  
  match "/:page_url" => "staticpages#show", :as => :static_page
  match "*path" => "redirect#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

