Bcn::Application.routes.draw do  
  resources :bitacoras
  resources :tramite_normativos
  resources :tramite_constitucionals

  resources :debate_types
  resources :tp_generated_params
  resources :taxonomy_terms
  resources :taxonomy_categories
  resources :tp_parameters
  resources :default_users_by_ot_types
  resources :am_module_configurations
  resources :poblamiento_generated_params
  resources :poblamiento_import_locations
  resources :poblamiento_file_formats
  resources :doc_type_am_configurations
  resources :task_transitions
  resources :poblamiento_params
  resources :observation_types
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

  # ############################################################################################################
  # RDF Interventions
  match "rdf_interventions" => 'rdf_interventions#create', :via => :post
  match "rdf_interventions" => 'rdf_interventions#index', :as => :rdf_interventions
  match "rdf_interventions/new" => 'rdf_interventions#new', :as => :new_rdf_intervention
  match "rdf_interventions/:rdf_uri" => 'rdf_interventions#update', :as => :update_rdf_intervention, :via => :put
  match "rdf_interventions/:rdf_uri" => 'rdf_interventions#destroy', :as => :destroy_rdf_intervention, :via => :delete
  match "rdf_interventions/:rdf_uri" => 'rdf_interventions#show', :as => :rdf_intervention
  match "rdf_interventions/:rdf_uri/edit" => 'rdf_interventions#edit', :as => :edit_rdf_intervention

  # ############################################################################################################
  # RDF Parties
  match "parties" => 'parties#create', :via => :post
  match "parties" => 'parties#index', :as => :rdf_parties
  match "parties/new" => 'parties#new', :as => :new_rdf_party
  match "parties/:rdf_uri" => 'parties#update', :as => :update_rdf_party, :via => :put
  match "parties/:rdf_uri" => 'parties#destroy', :as => :destroy_rdf_party, :via => :delete
  match "parties/:rdf_uri" => 'parties#show', :as => :rdf_party
  match "parties/:rdf_uri/edit" => 'parties#edit', :as => :edit_rdf_party

  # ############################################################################################################
  # RDF Qualities
  match "qualities" => 'qualities#create', :via => :post
  match "qualities" => 'qualities#index', :as => :rdf_qualities
  match "qualities/new" => 'qualities#new', :as => :new_rdf_quality
  match "qualities/:rdf_uri" => 'qualities#update', :as => :update_rdf_quality, :via => :put
  match "qualities/:rdf_uri" => 'qualities#destroy', :as => :destroy_rdf_quality, :via => :delete
  match "qualities/:rdf_uri" => 'qualities#show', :as => :rdf_quality
  match "qualities/:rdf_uri/edit" => 'qualities#edit', :as => :edit_rdf_quality

  # ############################################################################################################
  # RDF ParticipationTypes
  match "participation_types" => 'participation_types#create', :via => :post
  match "participation_types" => 'participation_types#index', :as => :rdf_participation_types
  match "participation_types/new" => 'participation_types#new', :as => :new_rdf_participation_type
  match "participation_types/:rdf_uri" => 'participation_types#update', :as => :update_rdf_participation_type, :via => :put
  match "participation_types/:rdf_uri" => 'participation_types#destroy', :as => :destroy_rdf_participation_type, :via => :delete
  match "participation_types/:rdf_uri" => 'participation_types#show', :as => :rdf_participation_type
  match "participation_types/:rdf_uri/edit" => 'participation_types#edit', :as => :edit_rdf_participation_type

  get "home/index"
  match "home/show_empty" => "home#show_empty", :as => :mostrar_vacio
  match "home/show_admin" => "home#show_admin", :as => :mostrar_admin
  match "home/show_analist" => "home#show_analist", :as => :mostrar_analista
  match "home/show_qa_analist" => "home#show_qa_analist", :as => :mostrar_analista_qa
  match "home/show_planner" => "home#show_planner", :as => :mostrar_planificador
  match "home/show_ot/:ot_id" => "home#show_ot", :as => :mostrar_ot
  match "home/edit_ot/:ot_id" => "home#edit_ot", :as => :editar_ot
  match "home/update_ot" => "home#update_ot", :as => :actualizar_ot, :method => :post
  match "home/show_document/:frbr_manifestation_id" => "home#show_document", :as => :mostrar_documento
  match "home/show_am_result/:am_result_id" => "home#show_am_result", :as => :mostrar_resultado_ma
  match "home/create_observation" => "home#create_observation", :as => :create_observation, :method => :post
  match "home/new_ot" => "home#new_ot", :as => :home_new_ot
  match "home/create_new_ot" => "home#create_new_ot", :as => :create_new_ot, :method => :post
  match "home/clear_database" => "home#clear_database", :as => :clear_database

  match "home/filter_ots/" => "home#filter_ots", :as => :filter_ots

  ######################################################################################################################################################################
  # Marcado Documento
  # States
  match "marcado_documento/perform_work/:task_id/(:event)" => "marcado_documento#perform_work", :as => :marcado_documento_perform_work
  # Posts
  match "marcado_documento/realizar_marcaje_automatico" => "marcado_documento#realizar_marcaje_automatico", :as => :realizar_marcaje_automatico, :method => :post
  match "marcado_documento/save_xml_document" => "marcado_documento#save_xml_document", :as => :marcado_documento_save_xml_document, :method => :post
  # Events
  match "marcado_documento/requiere_marcaje_automatico_event/:task_id" => "marcado_documento#requiere_marcaje_automatico_event", :as => :requiere_marcaje_automatico_event
  match "marcado_documento/no_requiere_marcaje_automatico_event/:task_id" => "marcado_documento#no_requiere_marcaje_automatico_event", :as => :no_requiere_marcaje_automatico_event
  match "marcado_documento/requiere_modificaciones_event/:task_id" => "marcado_documento#requiere_modificaciones_event", :as => :requiere_modificaciones_event
  match "marcado_documento/no_requiere_modificaciones_event/:task_id" => "marcado_documento#no_requiere_modificaciones_event", :as => :no_requiere_modificaciones_event
  match "marcado_documento/termina_correcciones_event/:task_id" => "marcado_documento#termina_correcciones_event", :as => :termina_correcciones_event
  match "marcado_documento/verifica_correcciones_event/:task_id" => "marcado_documento#verifica_correcciones_event", :as => :verifica_correcciones_event
  match "marcado_documento/termina_marcaje_automatico_event/:task_id" => "marcado_documento#termina_marcaje_automatico_event", :as => :termina_marcaje_automatico_event

  ######################################################################################################################################################################
  # QA Marcado Documento
  # States
  match "qa_documento/perform_work/:task_id/(:event)" => "qa_documento#perform_work", :as => :qa_documento_perform_work
  # Posts
  match "qa_documento/save_xml_document" => "qa_documento#save_xml_document", :as => :qa_documento_save_xml_document, :method => :post
  # Events
  match "qa_documento/recibe_notificacion_event/:task_id" => "qa_documento#recibe_notificacion_event", :as => :recibe_notificacion_event
  match "qa_documento/comienza_validar_event/:task_id" => "qa_documento#comienza_validar_event", :as => :comienza_validar_event
  match "qa_documento/rechaza_event/:task_id" => "qa_documento#rechaza_event", :as => :rechaza_event
  match "qa_documento/aprueba_tarea_event/:task_id" => "qa_documento#aprueba_tarea_event", :as => :aprueba_tarea_event
  match "qa_documento/aprueba_ot_event/:task_id" => "qa_documento#aprueba_ot_event", :as => :aprueba_ot_event
  match "qa_documento/publica_documento_event/:task_id" => "qa_documento#publica_documento_event", :as => :publica_documento_event

  ######################################################################################################################################################################
  # Marcado Cuenta workflow

  # Plan Marcado Cuenta
  # States
  match "plan_cuenta/perform_work/:task_id/(:event)" => "plan_cuenta#perform_work", :as => :plan_cuenta_perform_work
  match "plan_cuenta/eligiendo_documento" => "plan_cuenta#eligiendo_documento"
  # Posts
  match "plan_cuenta/create_document" => "plan_cuenta#create_document", :as => :plan_cuenta_crear_documento, :method => :post
  match "plan_cuenta/create_asignar_tareas" => "plan_cuenta#create_asignar_tareas", :as => :crear_asignar_tareas, :method => :post
  match "plan_cuenta/create_notificar_analista" => "plan_cuenta#create_notificar_analista", :as => :crear_notificar_analista, :method => :post

  ######################################################################################################################################################################
  # Marcado Diario workflow

  # Plan Marcado Diario
  match "plan_diario/perform_work/:task_id/(:event)"=> "plan_diario#perform_work", :as => :plan_diario_perform_work
  # States
  match "plan_diario/eligiendo_documento" => "plan_diario#eligiendo_documento"
  match "plan_diario/en_marcaje_automatico" => "plan_diario#en_marcaje_automatico"
  match "plan_diario/evaluando_resultados" => "plan_diario#evaluando_resultados"
  match "plan_diario/planifica_asignar_tareas" => "plan_diario#planifica_asignar_tareas"
  match "plan_diario/asignando_tareas" => "plan_diario#asignando_tareas"
  match "plan_diario/notificar_equipos" => "plan_diario#notificar_equipos"
  # Posts
  match "plan_diario/create_document" => "plan_cuenta#create_document", :as => :plan_diario_crear_documento, :method => :post
  match "plan_diario/realizar_marcaje_automatico" => "plan_diario#realizar_marcaje_automatico", :as => :marcaje_automatico_plan_diario, :method => :post
  match "plan_diario/create_dividir_tareas" => "plan_diario#create_dividir_tareas", :as => :create_dividir_tareas, :method => :post
  match "plan_diario/agregar_tarea/:task_id" => "plan_diario#agregar_tarea", :as => :agregar_tarea_marcado_diario
  match "plan_diario/create_asignar_tareas" => "plan_diario#create_asignar_tareas", :as => :crear_asignar_tareas_diario, :method => :post
  match "plan_diario/create_notificar_equipos" => "plan_diario#create_notificar_equipos", :as => :create_notificar_equipos, :method => :post
  # Events
  match "plan_diario/termina_evaluacion_event/:task_id" => "plan_diario#termina_evaluacion_event", :as => :termina_evaluacion_event
  match "plan_diario/decide_dividir_event/:task_id" => "plan_diario#decide_dividir_event", :as => :decide_dividir_event
  match "plan_diario/decide_no_dividir_event/:task_id" => "plan_diario#decide_no_dividir_event", :as => :decide_no_dividir_event

  # Marcado Diario Post
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
  # Plan Correccion workflow
  # States
  match "plan_correccion/perform_work/:task_id/(:event)" => "plan_correccion#perform_work", :as => :plan_cuenta_perform_work
  match "plan_correccion/eligiendo_documento" => "plan_correccion#eligiendo_documento", :as => :plan_cuenta_eligiendo_documento
  match "plan_correccion/asignando_tareas" => "plan_correccion#asignando_tareas", :as => :plan_cuenta_asignando_tareas
  match "plan_correccion/notificar_analista" => "plan_correccion#notificar_analista", :as => :plan_cuenta_notificar_analista
  # Posts
  match "plan_correccion/create_eligiendo_documento" => "plan_correccion#create_eligiendo_documento", :as => :plan_cuenta_create_eligiendo_documento, :method => :post
  match "plan_correccion/create_asignando_tareas" => "plan_correccion#create_asignando_tareas", :as => :plan_cuenta_create_asignando_tareas, :method => :post
  match "plan_correccion/create_notificar_analista" => "plan_correccion#create_notificar_analista", :as => :plan_cuenta_create_notificar_analista, :method => :post

  ######################################################################################################################################################################
  # Plan Poblamiento workflow
  # States
  match "plan_poblamiento/perform_work/:task_id/(:event)" => "plan_poblamiento#perform_work", :as => :plan_poblamiento_perform_work
  match "plan_poblamiento/determina_periodo" => "plan_poblamiento#determina_periodo", :as => :plan_poblamiento_determina_periodo
  match "plan_poblamiento/revisando_parametros" => "plan_poblamiento#revisando_parametros", :as => :plan_poblamiento_revisando_parametros
  match "plan_poblamiento/modificar_periodo" => "plan_poblamiento#modificar_periodo", :as => :plan_poblamiento_modificar_periodo
  match "plan_poblamiento/genera_ots" => "plan_poblamiento#genera_ots", :as => :plan_poblamiento_genera_ots
  match "plan_poblamiento/termina_poblamiento" => "plan_poblamiento#termina_poblamiento", :as => :plan_poblamiento_termina_poblamiento
  # Posts
  match "plan_poblamiento/create_params" => "plan_poblamiento#create_params", :as => :plan_poblamiento_create_params, :method => :post
  match "plan_poblamiento/update_params" => "plan_poblamiento#update_params", :as => :plan_poblamiento_update_params, :method => :put
  match "plan_poblamiento/modificar_parametros" => "plan_poblamiento#modificar_parametros", :as => :plan_poblamiento_modificar_parametros, :method => :post
  match "plan_poblamiento/create_genera_ots" => "plan_poblamiento#create_genera_ots", :as => :plan_poblamiento_create_genera_ots, :method => :post
  # Events
  match "plan_poblamiento/periodo_determinado_event/:task_id" => "plan_poblamiento#periodo_determinado_event", :as => :plan_poblamiento_periodo_determinado_event
  match "plan_poblamiento/aceptar_parametros_event/:task_id" => "plan_poblamiento#aceptar_parametros_event", :as => :plan_poblamiento_aceptar_parametros_event
  match "plan_poblamiento/rechazar_parametros_event/:task_id" => "plan_poblamiento#rechazar_parametros_event", :as => :plan_poblamiento_rechazar_parametros_event
  match "plan_poblamiento/periodo_modificado_event/:task_id" => "plan_poblamiento#periodo_modificado_event", :as => :plan_poblamiento_periodo_modificado_event
  match "plan_poblamiento/ots_generadas_event/:task_id" => "plan_poblamiento#ots_generadas_event", :as => :plan_poblamiento_ots_generadas_event

  ######################################################################################################################################################################
  # Plan Trabajo Parlamentario workflow
  # States
  match "plan_trabajo_parlamentario/perform_work/:task_id/(:event)" => "plan_trabajo_parlamentario#perform_work", :as => :plan_trabajo_parlamentario_perform_work
  match "plan_trabajo_parlamentario/inicial" => "plan_trabajo_parlamentario#inicial", :as => :plan_trabajo_parlamentario_inicial
  match "plan_trabajo_parlamentario/definiendo_parametros" => "plan_trabajo_parlamentario#definiendo_parametros", :as => :plan_trabajo_parlamentario_definiendo_parametros
  match "plan_trabajo_parlamentario/modificando_parametros" => "plan_trabajo_parlamentario#modificando_parametros", :as => :plan_trabajo_parlamentario_modificando_parametros
  match "plan_trabajo_parlamentario/revisando_parametros" => "plan_trabajo_parlamentario#revisando_parametros", :as => :plan_trabajo_parlamentario_revisando_parametros
  match "plan_trabajo_parlamentario/generando_ots" => "plan_trabajo_parlamentario#generando_ots", :as => :plan_trabajo_parlamentario_generando_ots
  # Posts
  match "plan_trabajo_parlamentario/create_params" => "plan_trabajo_parlamentario#create_params", :as => :plan_trabajo_parlamentario_create_params, :method => :post
  match "plan_trabajo_parlamentario/update_params" => "plan_trabajo_parlamentario#update_params", :as => :plan_trabajo_parlamentario_update_params, :method => :post
  match "plan_trabajo_parlamentario/create_genera_ots" => "plan_trabajo_parlamentario#create_genera_ots", :as => :plan_trabajo_parlamentario_genera_ots, :method => :post
  # Events
  match "plan_trabajo_parlamentario/comienza_definir_event/:task_id" => "plan_trabajo_parlamentario#comienza_definir_event", :as => :plan_trabajo_parlamentario_comienza_definir_event
  match "plan_trabajo_parlamentario/termina_definir_event/:task_id" => "plan_trabajo_parlamentario#termina_definir_event", :as => :plan_trabajo_parlamentario_termina_definir_event
  match "plan_trabajo_parlamentario/rechaza_parametros_event/:task_id" => "plan_trabajo_parlamentario#rechaza_parametros_event", :as => :plan_trabajo_parlamentario_rechaza_parametros_event
  match "plan_trabajo_parlamentario/acepta_parametros_event/:task_id" => "plan_trabajo_parlamentario#acepta_parametros_event", :as => :plan_trabajo_parlamentario_acepta_parametros_event

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
