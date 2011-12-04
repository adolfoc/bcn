Bcn::Application.routes.draw do
  resources :target_document_versions
  resources :markup_tools
  resources :am_configurations
  resources :am_observations
  resources :am_run_observation_types
  resources :am_results
  resources :intermediaries
  resources :delivery_methods
  resources :observations
  resources :ot_states
  resources :audits
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
  match "home/show_am_result/:am_result_id" => "home#show_am_result", :as => :mostrar_resultado_ma
  match "home/create_observation" => "home#create_observation", :as => :create_observation, :method => :post
  match "home/new_ot" => "home#new_ot", :as => :home_new_ot
  match "home/create_new_ot" => "home#create_new_ot", :as => :create_new_ot, :method => :post
  match "home/clear_database" => "home#clear_database", :as => :clear_database

  match "home/filter_ots/" => "home#filter_ots", :as => :filter_ots

  # Plan Marcado Cuenta workflow
  match "plan_cuenta/perform_work/:task_id/(:event)" => "plan_cuenta#perform_work", :as => :plan_cuenta_perform_work
  match "plan_cuenta/eligiendo_documento" => "plan_cuenta#eligiendo_documento"
  match "plan_cuenta/create_document" => "plan_cuenta#create_document", :as => :crear_documento, :method => :post
  match "plan_cuenta/create_asignar_tareas" => "plan_cuenta#create_asignar_tareas", :as => :crear_asignar_tareas, :method => :post
  match "plan_cuenta/create_notificar_analista" => "plan_cuenta#create_notificar_analista", :as => :crear_notificar_analista, :method => :post

  ######################################################################################################################################################################
  # Plan Marcado Diario workflow
  match "plan_diario/perform_work/:task_id/(:event)"=> "plan_diario#perform_work", :as => :plan_diario_perform_work
  # States
  match "plan_diario/eligiendo_documento" => "plan_diario#eligiendo_documento"
  match "plan_diario/en_marcaje_automatico" => "plan_diario#en_marcaje_automatico"
  match "plan_diario/evaluando_resultados" => "plan_diario#evaluando_resultados"
  match "plan_diario/planifica_asignar_tareas" => "plan_diario#planifica_asignar_tareas"
  match "plan_diario/asignando_tareas" => "plan_diario#asignando_tareas"
  match "plan_diario/notificar_equipos" => "plan_diario#notificar_equipos"
  # Posts
  match "plan_cuenta/create_document" => "plan_cuenta#create_document", :as => :crear_diario, :method => :post
  match "plan_diario/realizar_marcaje_automatico" => "plan_diario#realizar_marcaje_automatico", :as => :marcaje_automatico_plan_diario, :method => :post
  match "plan_diario/create_dividir_tareas" => "plan_diario#create_dividir_tareas", :as => :create_dividir_tareas, :method => :post
  match "plan_diario/agregar_tarea/:task_id" => "plan_diario#agregar_tarea", :as => :agregar_tarea_marcado_diario
  match "plan_diario/create_asignar_tareas" => "plan_diario#create_asignar_tareas", :as => :crear_asignar_tareas_diario, :method => :post
  match "plan_diario/create_notificar_equipos" => "plan_diario#create_notificar_equipos", :as => :create_notificar_equipos, :method => :post
  # Events
  match "plan_diario/termina_evaluacion_event/:task_id" => "plan_diario#termina_evaluacion_event", :as => :termina_evaluacion_event
  match "plan_diario/decide_dividir_event/:task_id" => "plan_diario#decide_dividir_event", :as => :decide_dividir_event
  match "plan_diario/decide_no_dividir_event/:task_id" => "plan_diario#decide_no_dividir_event", :as => :decide_no_dividir_event

  ######################################################################################################################################################################
  # Plan Marcado Diario Post workflow
  match "plan_diario_post/perform_work/:task_id/(:event)"=> "plan_diario_post#perform_work", :as => :plan_diario_post_perform_work
  # States
  match "plan_diario_post/esperando_notificacion_analista"=> "plan_diario_post#esperando_notificacion_analista", :as => :plan_diario_post_esperando_notificacion_analista
  match "plan_diario_post/verificando_completitud"=> "plan_diario_post#verificando_completitud", :as => :plan_diario_post_verificando_completitud
  match "plan_diario_post/revisando_documento_completo"=> "plan_diario_post#revisando_documento_completo", :as => :plan_diario_post_revisando_documento_completo
  match "plan_diario_post/asignando_tareas"=> "plan_diario_post#asignando_tareas", :as => :plan_diario_post_asignando_tareas
  match "plan_diario_post/publicando_diario_de_sesiones"=> "plan_diario_post#publicando_diario_de_sesiones", :as => :plan_diario_post_publicando_diario_de_sesiones
  match "plan_diario_post/notificando_equipos"=> "plan_diario_post#notificando_equipos", :as => :plan_diario_post_notificando_equipos
  # Posts
  match "plan_diario_post/publicar/:task_id"=> "plan_diario_post#publicar", :as => :plan_diario_post_publicar
  match "plan_diario_post/create_asignar_tareas"=> "plan_diario_post#create_asignar_tareas", :as => :plan_diario_post_create_asignar_tareas, :method => :post
  match "plan_diario_post/create_notificar_equipos"=> "plan_diario_post#create_notificar_equipos", :as => :plan_diario_post_create_notificar_equipos, :method => :post
  # Events
  match "plan_diario_post/recibe_notificacion_analista_event/:task_id" => "plan_diario_post#recibe_notificacion_analista_event", :as => :plan_diario_post_recibe_notificacion_analista_event
  match "plan_diario_post/trabajo_completo_event/:task_id" => "plan_diario_post#trabajo_completo_event", :as => :plan_diario_post_trabajo_completo_event
  match "plan_diario_post/trabajo_incompleto_event/:task_id" => "plan_diario_post#trabajo_incompleto_event", :as => :plan_diario_post_trabajo_incompleto_event
  match "plan_diario_post/evalua_trabajo_terminado_event/:task_id" => "plan_diario_post#evalua_trabajo_terminado_event", :as => :plan_diario_post_evalua_trabajo_terminado_event
  match "plan_diario_post/evalua_trabajo_incompleto_event/:task_id" => "plan_diario_post#evalua_trabajo_incompleto_event", :as => :plan_diario_post_evalua_trabajo_incompleto_event
  match "plan_diario_post/tareas_asignadas_event/:task_id" => "plan_diario_post#tareas_asignadas_event", :as => :plan_diario_post_tareas_asignadas_event

  ######################################################################################################################################################################
  # Marcado Cuenta workflow
  # States
  match "marcado_cuenta/perform_work/:task_id/(:event)" => "marcado_cuenta#perform_work", :as => :marcado_cuenta_perform_work
  # Posts
  match "marcado_cuenta/realizar_marcaje_automatico" => "marcado_cuenta#realizar_marcaje_automatico", :as => :realizar_marcaje_automatico, :method => :post
  match "marcado_cuenta/save_xml_document" => "marcado_cuenta#save_xml_document", :as => :marcado_cuenta_save_xml_document, :method => :post
  # Events
  match "marcado_cuenta/requiere_marcaje_automatico_event/:task_id" => "marcado_cuenta#requiere_marcaje_automatico_event", :as => :requiere_marcaje_automatico_event
  match "marcado_cuenta/no_requiere_marcaje_automatico_event/:task_id" => "marcado_cuenta#no_requiere_marcaje_automatico_event", :as => :no_requiere_marcaje_automatico_event
  match "marcado_cuenta/requiere_modificaciones_event/:task_id" => "marcado_cuenta#requiere_modificaciones_event", :as => :requiere_modificaciones_event
  match "marcado_cuenta/no_requiere_modificaciones_event/:task_id" => "marcado_cuenta#no_requiere_modificaciones_event", :as => :no_requiere_modificaciones_event
  match "marcado_cuenta/termina_correcciones_event/:task_id" => "marcado_cuenta#termina_correcciones_event", :as => :termina_correcciones_event
  match "marcado_cuenta/verifica_correcciones_event/:task_id" => "marcado_cuenta#verifica_correcciones_event", :as => :verifica_correcciones_event
  match "marcado_cuenta/termina_marcaje_automatico_event/:task_id" => "marcado_cuenta#termina_marcaje_automatico_event", :as => :termina_marcaje_automatico_event

  # QA Marcado Cuenta workflow
  match "qa_cuenta/perform_work/:task_id/(:event)" => "qa_cuenta#perform_work", :as => :qa_cuenta_perform_work
  match "qa_cuenta/recibe_notificacion_event/:task_id" => "qa_cuenta#recibe_notificacion_event", :as => :recibe_notificacion_event
  match "qa_cuenta/comienza_validar_event/:task_id" => "qa_cuenta#comienza_validar_event", :as => :comienza_validar_event
  match "qa_cuenta/rechaza_event/:task_id" => "qa_cuenta#rechaza_event", :as => :rechaza_event
  match "qa_cuenta/aprueba_tarea_event/:task_id" => "qa_cuenta#aprueba_tarea_event", :as => :aprueba_tarea_event
  match "qa_cuenta/aprueba_ot_event/:task_id" => "qa_cuenta#aprueba_ot_event", :as => :aprueba_ot_event
  match "qa_cuenta/publica_documento_event/:task_id" => "qa_cuenta#publica_documento_event", :as => :publica_documento_event

  # Plan Marcado Cuenta workflow
  match "plan_correccion/perform_work/:task_id/(:event)" => "plan_correccion#perform_work", :as => :plan_cuenta_perform_work
  match "plan_correccion/eligiendo_documento" => "plan_correccion#eligiendo_documento", :as => :plan_cuenta_eligiendo_documento
  match "plan_correccion/create_eligiendo_documento" => "plan_correccion#create_eligiendo_documento", :as => :plan_cuenta_create_eligiendo_documento, :method => :post
  match "plan_correccion/asignando_tareas" => "plan_correccion#asignando_tareas", :as => :plan_cuenta_asignando_tareas
  match "plan_correccion/create_asignando_tareas" => "plan_correccion#create_asignando_tareas", :as => :plan_cuenta_create_asignando_tareas, :method => :post
  match "plan_correccion/notificar_analista" => "plan_correccion#notificar_analista", :as => :plan_cuenta_notificar_analista
  match "plan_correccion/create_notificar_analista" => "plan_correccion#create_notificar_analista", :as => :plan_cuenta_create_notificar_analista, :method => :post

  match "users/index" => "users#index", :as => :users

  match "work_load/index" => "work_load#index", :as => :work_load
  match "work_load/select" => "work_load#select", :as => :select_work_load, :method => :post

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
