ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
     map.resources :users, :controller => 'user'

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  map.namespace :admin do |admin|
    map.connect ':controller/:action/:id'
    map.connect ':controller/:action/:id.:format'
  # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
    admin.resources :event
    admin.resources :gallery
    admin.resources :user
    admin.resources :main
    admin.resources :affiliate
  end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "access"

  map.namespace :access do |access|
    map.access 'contact', :controller => 'access', :action => 'contact' 
    map.access 'about', :controller => 'access', :action => 'about' 
    map.access 'plan_event', :controller => 'access', :action => 'plan_event' 
    map.access 'media', :controller => 'access', :action => 'media' 
  end
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.logout 'logout', :controller => 'user_session', :action => 'destroy'
  map.access_denied 'access_denied', :controller => 'access_denied'
end
