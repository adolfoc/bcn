# -*- coding: utf-8 -*-

require 'rdf_query'
require 'rdf_accessor'
require 'rdf_validator'

class Party
  include RdfQuery
  include RdfAccessor
  include RdfValidator

  ###############################################################################################
  # URIs de atributos en la base de datos Virtuoso

  RDF_PARTY_NS               = 'http://historiapolitica.bcn.cl/partidos_politicos/wiki/'

  RDF_PARTY_TYPE_URI         = 'http://datos.bcn.cl/ontologies/bcn-biographies#PoliticalParty'
  RDF_PARTY_NAME_URI         = "http://xmlns.com/foaf/0.1/name"
  RDF_PARTY_FOUNDER_URI      = "http://datos.bcn.cl/ontologies/bcn-biographies#hasParliamentaryFounder"
  RDF_PARTY_FOUNDATION_URI   = "http://datos.bcn.cl/ontologies/bcn-biographies#hasFoundationDate"
  RDF_PARTY_SOCIAL_URI       = "http://xmlns.com/foaf/0.1/isPrimaryTopicOf"
  RDF_PARTY_HOMEPAGE_URI     = "http://xmlns.com/foaf/0.1/hompage"
  RDF_PARTY_ELECTED_URI      = "http://datos.bcn.cl/ontologies/bcn-biographies#hasParliamentaryRepresentationOf"

  MAX_NAME_LENGTH = 100

  attr_accessor :rdf_uri
  RdfAccessor::rdf_uri_accessor('party_type', RdfAccessor::RDF_TYPE_URI)

  RdfAccessor::rdf_literal_accessor('party_name', RDF_PARTY_NAME_URI)
  RdfAccessor::rdf_uri_array_accessor('party_founders', RDF_PARTY_FOUNDER_URI)
  RdfAccessor::rdf_literal_accessor('party_foundation_date', RDF_PARTY_FOUNDATION_URI)
  RdfAccessor::rdf_uri_array_accessor('party_social_networks', RDF_PARTY_SOCIAL_URI)
  RdfAccessor::rdf_uri_accessor('party_homepage', RDF_PARTY_HOMEPAGE_URI)
  RdfAccessor::rdf_uri_array_accessor('party_elected_representatives', RDF_PARTY_ELECTED_URI)

  def initialize(rdf_uri, name)
    @rdf_uri = RDF::URI.new(rdf_uri)
    @party_name = RDF::Literal.new(name)
  end

  ###############################################################################################
  # Atributos derivados

  def id
    @rdf_uri.basename
  end

  def founders
    founders = Array.new
    unless party_founders.nil?
      party_founders.each do | party_founder_uri |
        founders << Parlamentarian.find(party_founder_uri)
      end
    end
    founders
  end

  def elected_representatives
    elected_representatives = Array.new
    unless party_elected_representatives.nil?
      party_elected_representatives.each do | elected_representatives_uri |
        elected_representatives << Parlamentarian.find(elected_representatives_uri)
      end
    end
    elected_representatives
  end

  def social_network(social_network_uri)
    /^http:\/\/(?<host>[a-z\.]*)\//.match(social_network_uri.to_s)[:host]
  end

  def has_url?
    return false if party_name.to_s.length == 0
    return false if /\./.match(id)
    true
  end

  ###############################################################################################
  # Validacion

  def errors
    RdfValidator::errors
  end

  # Validamos que el nombre este presente y que no sea el dado por defecto.
  def validate_name(name_value)
    RdfValidator::validate_attribute_pressence(:party_name, name_value, 'El nombre no puede estar en blanco')
    RdfValidator::validate_attribute_length(:party_name, name_value, MAX_NAME_LENGTH, 'El nombre no puede ser más largo que #{MAX_NAME_LENGTH} caracteres')
  end

  # Esta es la funcion que llamamos al crear una nueva instancia.
  def validate
    Rails.logger.debug('Party::validate')
    validate_name @party_name
    !errors.any?
  end

  # Esta es la funcion que llamamos al modificar una instancia.
  def validate_update(params)
    Rails.logger.debug('Party::validate_update')
    validate_name params[:party_name]
    !errors.any?
  end

  ###############################################################################################
  # Factory

  def initialize_new_instance(attributes)
#    @e_razon_social = RDF::Literal.new(attributes[:razon_social]) unless attributes[:razon_social].empty?
  end

  # Este metodo es invocado por el controlador al crear una nueva
  # instancia de esta clase para ser serializada.
  # Inicializamos la instancia con los valores entregados por el formulario
  # rellenado por el usuario.
  def self.create(attributes)
    Rails.logger.debug('Party::create ' + attributes.inspect)
    party = Party.new(RDF_PARTY_NEW_URI, attributes[:party_name])
    party.initialize_new_instance(attributes)
    party
  end

  # Una vez creada la nueva instancia por invocacion de +Party::Create+, el controlador llama al metodo save.
  # El metodo devuelve cierto o falso de acuerdo a si el nuevo objeto pasa la validacion o no.
  # Luego de pasar exitosamente la validacion, el metodo es responsable por cumplir con lo siguiente:
  # * Generar un id unico para esta instancia.
  # * Guardar todos los atributos.
  def save
    Rails.logger.debug('Party::save ' + self.inspect)
    return false unless validate

    generate_new_id

    # Guardar los otros atributos
    @party_type = RDF::URI.new(RDF_PARTY_TYPE_URI) if @party_type.nil?
    party_type_create

    @party_id = RDF::Literal.new("%010d" % Party.next_sequence_number) if @party_id.nil?
    party_id_create

    party_name_create

    true
  end

  # Generar ID para este partido
  def generate_new_id
    generate_new_sequence_number if party_id.nil?
  end

  def generate_new_sequence_number
    @party_id = RDF::Literal.new("%010d" % Party.next_sequence_number)
    @rdf_uri = RDF::URI.new(RDF_PARTY_NS + @party_id.to_s)

    Rails.logger.debug('Party::generate_new_sequence_number = ' + @rdf_uri)
  end

  # Devuelve el próximo número en serie para una nueva instancia.
  def self.next_sequence_number
    vars = Hash[:entity => RDF::URI, :id => RDF::Literal]

    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARTY_TYPE_URI}> .",
                          "?entity <#{RDF_PARTY_PARTY_ID_URI}> ?id ."
                          )

    last_id = RdfQuery::max(vars, :id, statements).to_i
    last_id + 1
  end

  # Este metodo es llamado desde el controlador al realizar una actualizacion.
  # Es la contrapartida de +save+ que es llamado cuando se genera un nuevo objeto.
  def update_attributes(params)
    Rails.logger.debug('Party::update_attributes')
    return false unless validate_update(params)

    party_name_update RDF::Literal.new(params[:party_name])
    true
  end

  def destroy
    Rails.logger.debug('Party::destroy')
    party_type_destroy
    party_id_destroy

    party_name_destroy
  end


  ###############################################################################################
  # Metodos de clase que devuelven colecciones
 
  def self.find_all(order = false, limit = 20, offset = 0)
    vars = Hash[:entity => RDF::URI, :name => RDF::Literal]
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARTY_TYPE_URI}> .",
                          "?entity <#{RDF_PARTY_NAME_URI}> ?name ."
                          )

    results = RdfQuery::execute_select(vars, statements, :name, limit, offset)

    rs = Array.new
    results.each { |result| rs << Party.new(result[:entity].to_s, result[:name].to_s) }
    rs
  end

  def self.count
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARTY_TYPE_URI}> ."
                          )

    RdfQuery::count(statements)
  end


  ###############################################################################################
  # Metodos de clase que devuelven instancias especificas
  def self.find_by_id(id)
    Party.find(RDF_PARTY_NS + id.to_s)
  end

  def self.find_by_sequence_number(number)
    Party.find(RDF_PARTY_NS + number.to_s)
  end

  def self.find(uri)
    Rails.logger.debug("Party::find(#{uri})")
    vars = Hash[:name => RDF::Literal]
    statements = Array.[](
                          "<#{uri}> <#{Party::RDF_PARTY_NAME_URI}> ?name ."
                          )

    results = RdfQuery::execute_select(vars, statements)

    name = ''
    results.each { |result| name = result[:name].to_s }

    return Party.new(uri, name)
  end
end
