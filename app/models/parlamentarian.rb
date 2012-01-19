# -*- coding: utf-8 -*-

require 'rdf_query'
require 'rdf_accessor'
require 'rdf_validator'

class Parlamentarian
  include RdfQuery
  include RdfAccessor
  include RdfValidator

  ###############################################################################################
  # URIs de atributos en la base de datos Virtuoso

  RDF_PARLAMENTARIAN_NS               = "http://historiapolitica.bcn.cl/resenas_parlamentarias/wiki"

  RDF_PARLAMENTARIAN_TYPE_URI         = 'http://datos.bcn.cl/ontologies/bcn-biographies#Parliamentary'
  RDF_PARLAMENTARIAN_NAME_URI         = "http://xmlns.com/foaf/0.1/name"
  RDF_PARLAMENTARIAN_FIRST_URI        = "http://xmlns.com/foaf/0.1/givenName"
  RDF_PARLAMENTARIAN_FATHER_N_URI     = "http://datos.bcn.cl/ontologies/bcn-biographies#surnameOfFather"
  RDF_PARLAMENTARIAN_MOTHER_N_URI     = "http://datos.bcn.cl/ontologies/bcn-biographies#surnameOfMother"
  RDF_PARLAMENTARIAN_PROFESSION_URI   = "http://datos.bcn.cl/ontologies/bcn-biographies#profession"
  RDF_PARLAMENTARIAN_DEPICTION_URI    = "http://xmlns.com/foaf/0.1/depiction"
  RDF_PARLAMENTARIAN_WEBSITE_URI      = "http://xmlns.com/foaf/0.1/homepage"
  RDF_PARLAMENTARIAN_TERMS_URI        = "http://datos.bcn.cl/ontologies/bcn-biographies#hasParliamentaryAppointment"
  RDF_PARLAMENTARIAN_SOCIAL_URI       = "http://xmlns.com/foaf/0.1/isPrimaryTopicOf"

  MAX_NAME_LENGTH = 100

  attr_accessor :rdf_uri
  RdfAccessor::rdf_uri_accessor('parlamentarian_type', RdfAccessor::RDF_TYPE_URI)

  RdfAccessor::rdf_literal_accessor('parlamentarian_name', RDF_PARLAMENTARIAN_NAME_URI)
  RdfAccessor::rdf_literal_accessor('parlamentarian_first_name', RDF_PARLAMENTARIAN_FIRST_URI)
  RdfAccessor::rdf_literal_accessor('parlamentarian_father_last_name', RDF_PARLAMENTARIAN_FATHER_N_URI)
  RdfAccessor::rdf_literal_accessor('parlamentarian_mother_last_name', RDF_PARLAMENTARIAN_MOTHER_N_URI)
  RdfAccessor::rdf_uri_array_accessor('parlamentarian_professions', RDF_PARLAMENTARIAN_PROFESSION_URI)
  RdfAccessor::rdf_literal_accessor('parlamentarian_depiction', RDF_PARLAMENTARIAN_DEPICTION_URI)
  RdfAccessor::rdf_uri_accessor('parlamentarian_website', RDF_PARLAMENTARIAN_WEBSITE_URI)
  RdfAccessor::rdf_uri_array_accessor('parlamentarian_terms', RDF_PARLAMENTARIAN_TERMS_URI)
  RdfAccessor::rdf_uri_array_accessor('parlamentarian_social_networks', RDF_PARLAMENTARIAN_SOCIAL_URI)

  def initialize(rdf_uri, name)
    @rdf_uri = RDF::URI.new(rdf_uri)
    @parlamentarian_name = RDF::Literal.new(name)
  end

  ###############################################################################################
  # Atributos derivados

  def id
    @rdf_uri.basename
  end

  def terms
    terms = Array.new
    parlamentarian_terms.each do | term_uri |
      terms << ParlamentaryPeriod.new(term_uri.to_s)
    end
    terms
  end

  def social_network(social_network_uri)
    /^http:\/\/(?<host>[a-z\.]*)\//.match(social_network_uri.to_s)[:host]
  end

  def profession
    profession = Array.new
    parlamentarian_professions.each do | profession_uri |
      profession << profession_uri.to_s
    end
    profession.join(", ")
  end

  ###############################################################################################
  # Metodos de clase que devuelven colecciones
 
  def self.find_all(order = false, limit = 20, offset = 0)
    vars = Hash[:entity => RDF::URI, :name => RDF::Literal]
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARLAMENTARIAN_TYPE_URI}> .",
                          "?entity <#{RDF_PARLAMENTARIAN_NAME_URI}> ?name ."
                          )

    results = RdfQuery::execute_select(vars, statements, :name, limit, offset)

    rs = Array.new
    results.each { |result| rs << Parlamentarian.new(result[:entity].to_s, result[:name].to_s) }
    rs
  end

  def self.count
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARLAMENTARIAN_TYPE_URI}> ."
                          )

    RdfQuery::count(statements)
  end

  ###############################################################################################
  # Metodos de clase que devuelven instancias especificas
  def self.find_by_id(id)
    self.find("#{RDF_PARLAMENTARIAN_NS}/#{id}")
  end

  def self.find(uri)
    Rails.logger.debug("Parlamentarian::find(#{uri})")
    vars = Hash[:name => RDF::Literal]
    statements = Array.[](
                          "<#{uri}> <#{Parlamentarian::RDF_PARLAMENTARIAN_NAME_URI}> ?name ."
                          )

    results = RdfQuery::execute_select(vars, statements)

    name = ''
    results.each { |result| name = result[:name].to_s }

    return Parlamentarian.new(uri, name)
  end
end
