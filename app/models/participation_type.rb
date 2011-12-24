# -*- coding: utf-8 -*-

require 'rdf_query'
require 'rdf_accessor'
require 'rdf_validator'

class ParticipationType
  include RdfQuery
  include RdfAccessor
  include RdfValidator

  ###############################################################################################
  # URIs de atributos en la base de datos Virtuoso

  RDF_PARTICIPATION_TYPE_NS                          = 'http://datos.bcn.cl/id/participation_type/'
  RDF_PARTICIPATION_TYPE_NEW_URI                     = 'http://datos.bcn.cl/id/participation_type/0'

  RDF_PARTICIPATION_TYPE_TYPE_URI                    = 'http://datos.bcn.cl/ontologies#ParticipationType'
  RDF_PARTICIPATION_TYPE_PARTICIPATION_TYPE_ID_URI   = 'http://datos.bcn.cl/id/participation_type/participation_typeId'
  RDF_PARTICIPATION_TYPE_NAME_URI                    = "http://datos.bcn.cl/foaf/0.1/name"

  MAX_NAME_LENGTH = 100

  attr_accessor :rdf_uri
  RdfAccessor::rdf_uri_accessor('participation_type_type', RdfAccessor::RDF_TYPE_URI)
  RdfAccessor::rdf_literal_accessor('participation_type_id', RDF_PARTICIPATION_TYPE_PARTICIPATION_TYPE_ID_URI)

  RdfAccessor::rdf_literal_accessor('participation_type_name', RDF_PARTICIPATION_TYPE_NAME_URI)

  def initialize(rdf_uri, name)
    @rdf_uri = RDF::URI.new(rdf_uri)
    @participation_type_name = RDF::Literal.new(name)
  end

  ###############################################################################################
  # Atributos derivados

  def id
    @rdf_uri.basename
  end

  ###############################################################################################
  # Validacion

  def errors
    RdfValidator::errors
  end

  # Validamos que el nombre este presente y que no sea el dado por defecto.
  def validate_name(name_value)
    RdfValidator::validate_attribute_pressence(:participation_type_name, name_value, 'El nombre no puede estar en blanco')
    RdfValidator::validate_attribute_length(:participation_type_name, name_value, MAX_NAME_LENGTH, 'El nombre no puede ser más largo que #{MAX_NAME_LENGTH} caracteres')
  end

  # Esta es la funcion que llamamos al crear una nueva instancia.
  def validate
    Rails.logger.debug('ParticipationType::validate')
    validate_name @participation_type_name
    !errors.any?
  end

  # Esta es la funcion que llamamos al modificar una instancia.
  def validate_update(params)
    Rails.logger.debug('ParticipationType::validate_update')
    validate_name params[:participation_type_name]
    !errors.any?
  end

  ###############################################################################################
  # Factory

  def initialize_new_instance(attributes)
  end

  # Este metodo es invocado por el controlador al crear una nueva
  # instancia de esta clase para ser serializada.
  # Inicializamos la instancia con los valores entregados por el formulario
  # rellenado por el usuario.
  def self.create(attributes)
    Rails.logger.debug('ParticipationType::create ' + attributes.inspect)
    participation_type = ParticipationType.new(RDF_PARTICIPATION_TYPE_NEW_URI, attributes[:participation_type_name])
    participation_type.initialize_new_instance(attributes)
    participation_type
  end

  # Una vez creada la nueva instancia por invocacion de +ParticipationType::Create+, el controlador llama al metodo save.
  # El metodo devuelve cierto o falso de acuerdo a si el nuevo objeto pasa la validacion o no.
  # Luego de pasar exitosamente la validacion, el metodo es responsable por cumplir con lo siguiente:
  # * Generar un id unico para esta instancia.
  # * Guardar todos los atributos.
  def save
    Rails.logger.debug('ParticipationType::save ' + self.inspect)
    return false unless validate

    generate_new_id

    # Guardar los otros atributos
    @participation_type_type = RDF::URI.new(RDF_PARTICIPATION_TYPE_TYPE_URI) if @participation_type_type.nil?
    participation_type_type_create

    @participation_type_id = RDF::Literal.new("%010d" % ParticipationType.next_sequence_number) if @participation_type_id.nil?
    participation_type_id_create

    participation_type_name_create

    true
  end

  # Generar ID para esta calidad
  def generate_new_id
    generate_new_sequence_number if participation_type_id.nil?
  end

  def generate_new_sequence_number
    @participation_type_id_create = RDF::Literal.new("%010d" % ParticipationType.next_sequence_number)
    @rdf_uri = RDF::URI.new(RDF_PARTICIPATION_TYPE_NS + @participation_type_id_create.to_s)

    Rails.logger.debug('ParticipationType::generate_new_sequence_number = ' + @rdf_uri)
  end

  # Devuelve el próximo número en serie para una nueva instancia.
  def self.next_sequence_number
    vars = Hash[:entity => RDF::URI, :id => RDF::Literal]

    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARTICIPATION_TYPE_TYPE_URI}> .",
                          "?entity <#{RDF_PARTICIPATION_TYPE_PARTICIPATION_TYPE_ID_URI}> ?id ."
                          )

    last_id = RdfQuery::max(vars, :id, statements).to_i
    last_id + 1
  end

  # Este metodo es llamado desde el controlador al realizar una actualizacion.
  # Es la contrapartida de +save+ que es llamado cuando se genera un nuevo objeto.
  def update_attributes(params)
    Rails.logger.debug('ParticipationType::update_attributes')
    return false unless validate_update(params)

    participation_type_name_update RDF::Literal.new(params[:participation_type_name])
    true
  end

  def destroy
    Rails.logger.debug('ParticipationType::destroy')
    participation_type_type_destroy
    participation_type_id_destroy

    participation_type_name_destroy
  end


  ###############################################################################################
  # Metodos de clase que devuelven colecciones

  def self.find_all(order = false, limit = 20, offset = 0)
    vars = Hash[:entity => RDF::URI, :name => RDF::Literal]
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARTICIPATION_TYPE_TYPE_URI}> .",
                          "?entity <#{RDF_PARTICIPATION_TYPE_NAME_URI}> ?name ."
                          )

    results = RdfQuery::execute_select(vars, statements, :name, limit, offset)

    rs = Array.new
    results.each { |result| rs << ParticipationType.new(result[:entity].to_s, result[:name].to_s) }
    rs
  end

  def self.count
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARTICIPATION_TYPE_TYPE_URI}> ."
                          )

    RdfQuery::count(statements)
  end


  ###############################################################################################
  # Metodos de clase que devuelven instancias especificas
  def self.find_by_id(id)
    Party.find(RDF_PARTICIPATION_TYPE_NS + id.to_s)
  end

  def self.find_by_sequence_number(number)
    Party.find(RDF_PARTICIPATION_TYPE_NS + number.to_s)
  end

  def self.find(uri)
    Rails.logger.debug("ParticipationType::find(#{uri})")
    vars = Hash[:name => RDF::Literal]
    statements = Array.[](
                          "<#{uri}> <#{ParticipationType::RDF_PARTICIPATION_TYPE_NAME_URI}> ?name ."
                          )

    results = RdfQuery::execute_select(vars, statements)

    name = ''
    results.each { |result| name = result[:name].to_s }

    return ParticipationType.new(uri, name)
  end
end
