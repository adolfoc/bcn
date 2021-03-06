require 'workflow_controller'

class QaDocumentoController < ApplicationController
  include WorkflowController

  DEBATES_BODY = "ProyectosDeAcuerdo/Cuerpo/TextoDebate"
  DEBATES_TITLE = "Debate"
  PROJECTS_BODY = "ProyectosDeAcuerdo/Cuerpo/ProyectoAcuerdo"
  PROJECTS_TITLE = "Proyectos de Acuerdo"
  INCIDENTS_BODY = "ParteIncidentes/Cuerpo/PeticionesDeOficio"
  INCIDENTS_TITLE = "Incidentes"

  before_filter :set_menu_section

  ##########################################################
  # Helpers
  ##########################################################
  def set_menu_section
    @accordion_section = 0
  end

  def clear_previous_interventions(organism, legislature, session)
    query = "DELETE FROM <http://datos.bcn.cl> { ?s ?p ?o } WHERE { 
      ?s <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://datos.bcn.cl/ontologies#Intervention>. 
      ?s <http://datos.bcn.cl/intervention/organism> '#{organism}' .
      ?s <http://datos.bcn.cl/intervention/legislature> '#{legislature}' .
      ?s <http://datos.bcn.cl/intervention/session> '#{session}' .
      ?s ?p ?o
    }"

    RdfQuery::sparql_query(query)
  end

  def create_intervention_node(organism, legislature, session, section, subsection, person, text)
    params = Hash.new
    params[:intervention_organism] = organism
    params[:intervention_legislature] = legislature
    params[:intervention_session] = session
    params[:intervention_ds_section] = section
    params[:intervention_ds_subsection] = subsection
    params[:intervention_person] = person
    params[:intervention_participation_type] = "0000000004"
    params[:intervention_role] = "0000000003"
    params[:intervention_text] = text

    intervention = RdfIntervention.create(params)
    intervention.save
  end

  def extract_section(doc, camara, legislatura, sesion, section_xpath, section_name)
    max = doc.xpath("//#{section_xpath}").count
    (0..max - 1).each do |index|
      subsection_title = doc.xpath("//#{section_xpath}/Titulo")[index].text
      body = doc.xpath("//#{section_xpath}/Cuerpo")[index]
      body.xpath('Participacion/Intervencion').each do |intervention|
        unless intervention.xpath('Emisor/entity/body').nil? || intervention.xpath('Emisor/entity/body').attribute('uri').nil?
          emisor_uri = intervention.xpath('Emisor/entity/body').attribute('uri').value
          text = intervention.xpath('texto').text

          create_intervention_node(camara, legislatura, sesion, section_name,  subsection_title, emisor_uri, text)
        end
      end
    end
  end

  def publish_ds(camara, legislatura, sesion)
    clear_previous_interventions(camara, legislatura, sesion)

    frbr_manifestation = FrbrManifestation.find(@ot.target_frbr_manifestation_id)
    filename = "#{Rails.root.to_s}/public/system/documents/#{frbr_manifestation.id.to_s}/original/#{frbr_manifestation.document_file_name}"
    doc = Nokogiri::XML(File.open(filename, 'r'))

    extract_section(doc, camara, legislatura, sesion, DEBATES_BODY, DEBATES_TITLE)
    extract_section(doc, camara, legislatura, sesion, PROJECTS_BODY, PROJECTS_TITLE)
    extract_section(doc, camara, legislatura, sesion, INCIDENTS_BODY, INCIDENTS_TITLE)
  end

  ##########################################################
  # Controller interface: States
  ##########################################################

  def perform_work
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)
    @event = params[:event]

    case @task.workflow_state
    when "esperando_notificacion_analista"
      esperando_notificacion_analista
    when "por_validar_qa"
      por_validar_qa
    when "evalua_qa"
      evalua_qa
    when "devuelve_a_analista"
      devuelve_a_analista
    when "devuelve_a_planificador"
      devuelve_a_planificador
    when "guarda_documento"
      guarda_documento
    end
  end

  # Actions that bring back a state

  # GET esperando_notificacion_analista
  def esperando_notificacion_analista
    screen_name("#{@task.class.to_s}/esperando_notificacion_analista")

    respond_to do |format|
      format.html { render action: "esperando_notificacion_analista" }
      format.json { head :ok }
    end
  end

  # GET por_validar_qa
  def por_validar_qa
    screen_name("#{@task.class.to_s}/por_validar_qa")

    respond_to do |format|
      format.html { render action: "por_validar_qa" }
      format.json { head :ok }
    end
  end

  # GET evalua_qa
  def evalua_qa
    screen_name("#{@task.class.to_s}/evalua_qa")

    # Read it so we can display it
    frbr_manifestation = FrbrManifestation.find(@ot.target_frbr_manifestation_id)
    @xml_text = File.open("#{Rails.root.to_s}/public/system/documents/#{frbr_manifestation.id.to_s}/original/#{frbr_manifestation.document_file_name}", 'r') { |f| f.read }

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    respond_to do |format|
      format.html { render action: "evalua_qa" }
      format.json { head :ok }
    end
  end

  # POST save_xml_document
  def save_xml_document
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task.id)

    screen_name("#{@task.class.to_s}/evalua_qa")

    # Read it so we can display it
    @xml_text = get_dummy_text

    # Mimic saving document to versioning repository
    generate_new_document_version(2)

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    respond_to do |format|
      format.html { render action: "evalua_qa" }
      format.json { head :ok }
    end
  end

  # GET devuelve_a_analista
  def devuelve_a_analista
    screen_name("#{@task.class.to_s}/devuelve_a_analista")

    respond_to do |format|
      format.html { render action: "devuelve_a_analista" }
      format.json { head :ok }
    end
  end

  # GET devuelve_a_planificador
  def devuelve_a_planificador
    screen_name("#{@task.class.to_s}/devuelve_a_planificador")

    respond_to do |format|
      format.html { render action: "devuelve_a_planificador" }
      format.json { head :ok }
    end
  end

  # GET guarda_documento
  def guarda_documento
    screen_name("#{@task.class.to_s}/guarda_documento")

    respond_to do |format|
      format.html { render action: "guarda_documento" }
      format.json { head :ok }
    end
  end

  ##########################################################
  # Controller interface: Events and transitions
  ##########################################################

  def recibe_notificacion_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:recibe_notificacion)

    respond_to do |format|
      format.html { render action: "por_validar_qa" }
      format.json { head :ok }
    end
  end

  def comienza_validar_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:comienza_validar)

    # Read it so we can display it
    frbr_manifestation = FrbrManifestation.find(@ot.target_frbr_manifestation_id)
    @xml_text = File.open("#{Rails.root.to_s}/public/system/documents/#{frbr_manifestation.id.to_s}/original/#{frbr_manifestation.document_file_name}", 'r') { |f| f.read }

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    respond_to do |format|
      format.html { render action: "evalua_qa" }
      format.json { head :ok }
    end
  end

  def rechaza_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:rechaza)

    # Call next workflow
    next_task = @task.predecessor
    call_next_workflow(next_task)
  
    # Make first transition
    @task = next_task
    do_perform_transition(:asignacion)

    respond_to do |format|
      format.html { render action: "devuelve_a_analista" }
      format.json { head :ok }
    end
  end

  def aprueba_tarea_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:aprueba_tarea)

    # Call next workflow
    next_task = @task.successor
    call_next_workflow(next_task)
  
    # Make first transition
    @task = next_task
    do_perform_transition(:recibe_notificacion_analista)

    respond_to do |format|
      format.html { render action: "devuelve_a_planificador" }
      format.json { head :ok }
    end
  end

  def aprueba_ot_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:aprueba_ot)

    respond_to do |format|
      format.html { render action: "guarda_documento" }
      format.json { head :ok }
    end
  end

  def publica_documento_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    frbr_work = @ot.source_frbr_manifestation.frbr_expression.frbr_work
    publish_ds(frbr_work.frbr_entity.name, frbr_work.legislature.to_s, frbr_work.session.to_s)

#    do_perform_transition(:publica_documento)
#    @task.mark_complete
#    @ot.mark_complete

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :ok }
    end
  end
end
