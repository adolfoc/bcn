# -*- coding: utf-8 -*-

require 'rdf_query'
require 'rdf_accessor'
require 'rdf_validator'

class RdfIntervention
  include RdfQuery
  include RdfAccessor
  include RdfValidator

  ###############################################################################################
  # URIs de atributos en la base de datos Virtuoso

  RDF_INTERVENTION_NS                       = 'http://datos.bcn.cl/id/intervention/'
  RDF_INTERVENTION_NEW_URI                  = 'http://datos.bcn.cl/id/intervention/0'

  RDF_INTERVENTION_TYPE_URI                 = 'http://datos.bcn.cl/ontologies#Intervention'
  RDF_INTERVENTION_PARTICIPATION_ID_URI     = 'http://datos.bcn.cl/intervention/interventionId'
  RDF_INTERVENTION_ORGANISM_URI             = "http://datos.bcn.cl/intervention/organism"
  RDF_INTERVENTION_LEGISLATURE_URI          = "http://datos.bcn.cl/intervention/legislature"
  RDF_INTERVENTION_SESSION_URI              = "http://datos.bcn.cl/intervention/session"
  RDF_INTERVENTION_PERSON_URI               = "http://datos.bcn.cl/intervention/person"
  RDF_INTERVENTION_TEXT_URI                 = "http://datos.bcn.cl/intervention/text"

  MAX_NAME_LENGTH = 100

  attr_accessor :rdf_uri
  RdfAccessor::rdf_uri_accessor('intervention_type', RdfAccessor::RDF_TYPE_URI)
  RdfAccessor::rdf_literal_accessor('intervention_id', RDF_INTERVENTION_PARTICIPATION_ID_URI)

  RdfAccessor::rdf_literal_accessor('intervention_organism', RDF_INTERVENTION_ORGANISM_URI)
  RdfAccessor::rdf_literal_accessor('intervention_legislature', RDF_INTERVENTION_LEGISLATURE_URI)
  RdfAccessor::rdf_literal_accessor('intervention_session', RDF_INTERVENTION_SESSION_URI)
  RdfAccessor::rdf_uri_accessor('intervention_person', RDF_INTERVENTION_PERSON_URI)
  RdfAccessor::rdf_literal_accessor('intervention_text', RDF_INTERVENTION_TEXT_URI)

  def initialize(rdf_uri)
    @rdf_uri = RDF::URI.new(rdf_uri)
  end

  ###############################################################################################
  # Atributos derivados

  def id
    @rdf_uri.basename
  end

  def encode_text(text_raw)
    Rails.logger.debug("RdfIntervention::encode_text entrada " + text_raw.inspect)
    salida = text_raw.strip
    salida = salida.gsub(/\r/, "\\\\r")
    salida = salida.gsub(/\n/, "\\\\n")
    salida = salida.gsub(/\t/, "\\\\t")
    salida = salida.gsub(/"/, "\\\\\"")
    Rails.logger.debug("RdfIntervention::encode_text salida " + salida.inspect) if !salida.nil?
    salida
  end


  ###############################################################################################
  # Validacion

  def errors
    RdfValidator::errors
  end

  # Validamos que el nombre este presente y que no sea el dado por defecto.
  # Esta es la funcion que llamamos al crear una nueva instancia.
  def validate
    Rails.logger.debug('RdfIntervention::validate')
    !errors.any?
  end

  # Esta es la funcion que llamamos al modificar una instancia.
  def validate_update(params)
    Rails.logger.debug('RdfIntervention::validate_update')
    !errors.any?
  end

  ###############################################################################################
  # Factory

  def initialize_new_instance(attributes)
    @intervention_organism = RDF::Literal.new(attributes[:intervention_organism]) unless attributes[:intervention_organism].empty?
    @intervention_legislature = RDF::Literal.new(attributes[:intervention_legislature]) unless attributes[:intervention_legislature].empty?
    @intervention_session = RDF::Literal.new(attributes[:intervention_session]) unless attributes[:intervention_session].empty?
    @intervention_person = RDF::URI.new(attributes[:intervention_person]) unless attributes[:intervention_person].empty?
    @intervention_text = RDF::Literal.new(encode_text(attributes[:intervention_text])) unless attributes[:intervention_text].empty?
  end

  # Este metodo es invocado por el controlador al crear una nueva
  # instancia de esta clase para ser serializada.
  # Inicializamos la instancia con los valores entregados por el formulario
  # rellenado por el usuario.
  def self.create(attributes)
    Rails.logger.debug('RdfIntervention::create ' + attributes.inspect)
    intervention = RdfIntervention.new(RDF_INTERVENTION_NEW_URI)
    intervention.initialize_new_instance(attributes)
    intervention
  end

  # Una vez creada la nueva instancia por invocacion de +Party::Create+, el controlador llama al metodo save.
  # El metodo devuelve cierto o falso de acuerdo a si el nuevo objeto pasa la validacion o no.
  # Luego de pasar exitosamente la validacion, el metodo es responsable por cumplir con lo siguiente:
  # * Generar un id unico para esta instancia.
  # * Guardar todos los atributos.
  def save
    Rails.logger.debug('RdfIntervention::save ' + self.inspect)
    return false unless validate

    generate_new_id

    # Guardar los otros atributos
    @intervention_type = RDF::URI.new(RDF_INTERVENTION_TYPE_URI) if @intervention_type.nil?
    intervention_type_create

    @intervention_id = RDF::Literal.new("%010d" % RdfIntervention.next_sequence_number) if @intervention_id.nil?
    intervention_id_create

    intervention_organism_create
    intervention_legislature_create
    intervention_session_create
    intervention_person_create
    intervention_text_create

    true
  end

  # Generar ID para esta participacion
  def generate_new_id
    generate_new_sequence_number if intervention_id.nil?
  end

  def generate_new_sequence_number
    @intervention_id = RDF::Literal.new("%010d" % RdfIntervention.next_sequence_number)
    @rdf_uri = RDF::URI.new(RDF_INTERVENTION_NS + @intervention_id.to_s)

    Rails.logger.debug('RdfIntervention::generate_new_sequence_number = ' + @rdf_uri)
  end

  # Devuelve el próximo número en serie para una nueva instancia.
  def self.next_sequence_number
    vars = Hash[:entity => RDF::URI, :id => RDF::Literal]

    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_INTERVENTION_TYPE_URI}> .",
                          "?entity <#{RDF_INTERVENTION_PARTICIPATION_ID_URI}> ?id ."
                          )

    last_id = RdfQuery::max(vars, :id, statements).to_i
    last_id + 1
  end

  # Este metodo es llamado desde el controlador al realizar una actualizacion.
  # Es la contrapartida de +save+ que es llamado cuando se genera un nuevo objeto.
  def update_attributes(params)
    Rails.logger.debug('RdfIntervention::update_attributes')
    return false unless validate_update(params)

    intervention_organism_update RDF::Literal.new(params[:intervention_organism])
    intervention_legislature_update RDF::Literal.new(params[:intervention_legislature])
    intervention_session_update RDF::Literal.new(params[:intervention_session])
    intervention_person_update RDF::URI.new(params[:intervention_person])
    intervention_text_update RDF::Literal.new(encode_text(params[:intervention_text]))
    true
  end

  def destroy
    Rails.logger.debug('RdfIntervention::destroy')
    intervention_type_destroy
    intervention_id_destroy

    intervention_organism_destroy
    intervention_legislature_destroy
    intervention_session_destroy
    intervention_person_destroy
    intervention_text_destroy
  end


  ###############################################################################################
  # Metodos de clase que devuelven colecciones

  def self.find_all(order = false, limit = 20, offset = 0)
    vars = Hash[:entity => RDF::URI]
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_INTERVENTION_TYPE_URI}> ."
                          )

    results = RdfQuery::execute_select(vars, statements, nil, limit, offset)

    rs = Array.new
    results.each { |result| rs << RdfIntervention.new(result[:entity].to_s) }
    rs
  end

  def self.count
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_INTERVENTION_TYPE_URI}> ."
                          )

    RdfQuery::count(statements)
  end


  ###############################################################################################
  # Metodos de clase que devuelven instancias especificas
  def self.find_by_id(id)
    RdfIntervention.find(RDF_INTERVENTION_NS + id.to_s)
  end

  def self.find_by_sequence_number(number)
    RdfIntervention.find(RDF_INTERVENTION_NS + number.to_s)
  end

  def self.find(uri)
    Rails.logger.debug("RdfIntervention::find(#{uri})")
    vars = Hash[:name => RDF::Literal]
    statements = Array.[](
                          "<#{uri}> <#{RDF_TYPE_URI}> <#{RDF_INTERVENTION_TYPE_URI}> ."
                          )

#    results = RdfQuery::execute_select(vars, statements)

    name = ''
#    results.each { |result| name = result[:name].to_s }

    return RdfIntervention.new(uri)
  end
end
