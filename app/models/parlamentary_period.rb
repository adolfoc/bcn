# -*- coding: utf-8 -*-

require 'rdf_query'
require 'rdf_accessor'
require 'rdf_validator'

class ParlamentaryPeriod
  include RdfQuery
  include RdfAccessor
  include RdfValidator

  ###############################################################################################
  # URIs de atributos en la base de datos Virtuoso

  RDF_PARLAMENTARY_PERIOD_NS               = "http://historiapolitica.bcn.cl/resenas_parlamentarias/wiki"

  RDF_PARLAMENTARY_PERIOD_TYPE_URI         = 'http://datos.bcn.cl/ontologies/bcn-biographies#ParliamentaryPeriod'
  RDF_PARLAMENTARY_PERIOD_START_YEAR_URI   = "http://www.w3.org/2006/time#hasBeginning"
  RDF_PARLAMENTARY_PERIOD_END_YEAR_URI     = "http://www.w3.org/2006/time#hasEnd"
  RDF_PARLAMENTARY_PERIOD_PARTY_URI        = "http://datos.bcn.cl/ontologies/bcn-biographies#hasPoliticalParty"
  RDF_PARLAMENTARY_PERIOD_DISTRICT_WS_URI  = "http://datos.bcn.cl/ontologies/bcn-biographies#hasParliamentaryRepresentationIn"

  attr_accessor :rdf_uri
  RdfAccessor::rdf_uri_accessor('parlamentary_period_type', RdfAccessor::RDF_TYPE_URI)

  RdfAccessor::rdf_literal_accessor('parlamentary_period_start_year', RDF_PARLAMENTARY_PERIOD_START_YEAR_URI)
  RdfAccessor::rdf_literal_accessor('parlamentary_period_end_year', RDF_PARLAMENTARY_PERIOD_END_YEAR_URI)
  RdfAccessor::rdf_uri_accessor('parlamentary_period_party', RDF_PARLAMENTARY_PERIOD_PARTY_URI)
  RdfAccessor::rdf_uri_accessor('parlamentary_period_district_website', RDF_PARLAMENTARY_PERIOD_DISTRICT_WS_URI)

  def initialize(rdf_uri)
    @rdf_uri = RDF::URI.new(rdf_uri)
  end

  ###############################################################################################
  # Atributos derivados

  def person
    @rdf_uri.basename
  end

  def year
    /-(?<year>[0-9]*)$/.match(@rdf_uri)[:year]
  end

  def role
    /#(?<role>[a-z ]*)-(?<year>[0-9]*)$/.match(rdf_uri)[:role]
  end

  def party
    Party.find(parlamentary_period_party.to_s)
  end


  ###############################################################################################
  # Metodos de clase que devuelven colecciones
 
  def self.find_all(order = false, limit = 20, offset = 0)
    vars = Hash[:entity => RDF::URI]
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARLAMENTARY_PERIOD_TYPE_URI}> ",
                          )

    results = RdfQuery::execute_select(vars, statements, nil, limit, offset)

    rs = Array.new
    results.each { |result| rs << ParlamentaryPeriod.new(result[:entity].to_s) }
    rs
  end

  def self.count
    statements = Array.[](
                          "?entity <#{RDF_TYPE_URI}> <#{RDF_PARLAMENTARY_PERIOD_TYPE_URI}> ."
                          )

    RdfQuery::count(statements)
  end


  ###############################################################################################
  # Metodos de clase que devuelven instancias especificas
  def self.find_by_name_role_period(name, role, period)
    self.find("#{RDF_PARLAMENTARY_PERIOD_NS}/#{name}##{role}-#{period}")
  end

  def self.find(uri)
    Rails.logger.debug("ParlamentaryPeriod::find(#{uri})")
#    vars = Hash[:name => RDF::Literal]
#    statements = Array.[](
#                          "<#{uri}> <#{ParlamentaryPeriod::RDF_PARLAMENTARIAN_NAME_URI}> ?name ."
#                          )

#    results = RdfQuery::execute_select(vars, statements)

#    name = ''
#    results.each { |result| name = result[:name].to_s }

    return ParlamentaryPeriod.new(uri)
  end
end
