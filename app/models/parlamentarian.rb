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

  RDF_PARLAMENTARIAN_TYPE_URI         = 'http://datos.bcn.cl/ontologies/bcn-biographies#Parliamentary'
  RDF_PARLAMENTARIAN_NAME_URI         = "http://xmlns.com/foaf/0.1/name"

  MAX_NAME_LENGTH = 100

  attr_accessor :rdf_uri
  RdfAccessor::rdf_uri_accessor('parlamentarian_type', RdfAccessor::RDF_TYPE_URI)

  RdfAccessor::rdf_literal_accessor('parlamentarian_name', RDF_PARLAMENTARIAN_NAME_URI)

  def initialize(rdf_uri, name)
    @rdf_uri = RDF::URI.new(rdf_uri)
    @parlamentarian_name = RDF::Literal.new(name)
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
