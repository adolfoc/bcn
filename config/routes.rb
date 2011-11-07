Bcn::Application.routes.draw do
  resources :frbr_manifestations
  resources :frbr_expressions
  resources :frbr_document_types
  resources :frbr_works
  resources :frbr_bcn_types
  resources :frbr_entities
  resources :task_types
  resources :roles
  resources :priorities
  resources :ot_types
  resources :ots
  resources :tasks
  devise_for :users

  get "home/index"
  match "home/show_empty" => "home#show_empty", :as => :mostrar_vacio
  match "home/show_admin" => "home#show_admin", :as => :mostrar_admin
  match "home/show_analist" => "home#show_analist", :as => :mostrar_analista
  match "home/show_qa_analist" => "home#show_qa_analist", :as => :mostrar_analista_qa
  match "home/show_planner" => "home#show_planner", :as => :mostrar_planificador
  match "home/show_ot/:ot_id" => "home#show_ot", :as => :mostrar_ot
  match "home/show_document/:frbr_manifestation_id" => "home#show_document", :as => :mostrar_documento

  match "marcado_cuenta/perform_work/:task_id/(:event)" => "marcado_cuenta#perform_work", :as => :marcado_cuenta_perform_work

  match "qa_cuenta/perform_work/:task_id/(:event)" => "qa_cuenta#perform_work", :as => :qa_cuenta_perform_work

  match "users/index" => "users#index", :as => :users

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
