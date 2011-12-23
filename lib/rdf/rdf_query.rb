# -*- coding: utf-8 -*-
require 'net/http'
require 'cgi'
require 'json'

# El módulo +RdfQuery+ declara métodos para invocar el endpoint +SPARQL+ de _Virtuoso_.
# Además incluye funciones para leer los valores devueltos en JSON.

module RdfQuery

  SPARQL_ENDPOINT = Rails.application.config.rdf_sparql_endpoint
  DEFAULT_GRAPH_URI = Rails.application.config.rdf_default_graph
  SPARQL_NS = "http://www.w3.org/2005/sparql-results#"

  @@trace_on = false

  # Aqui realizamos el query sparql.
  # Pedimos los resultados en formato JSON
  def sparql_query(query, baseURL = SPARQL_ENDPOINT, format = "application/sparql-results+json")
    Rails.logger.debug("RdfJsonQuery::sparql_query: endpoint #{baseURL}, query: " + query) if @@trace_on == true

    params = {
      "default-graph" => "#{DEFAULT_GRAPH_URI}",
      "query" => query,
      "debug" => "on",
      "timeout" => "",
      "format" => format,
      "save" => "display",
      "fname" => ""
    }

    querypart = ""
    params.each { |k, v|
      querypart += "#{k}=#{CGI.escape(v)}&"
    }

    sparqlURL = baseURL + "?#{querypart}"

    response = Net::HTTP.get_response(URI.parse(sparqlURL))

    Rails.logger.debug("RdfJsonQuery::sparql_query: response: " + response.body) if @@trace_on == true

    return response.body
  end

  ###############################################################################################
  # Helpers

  def combine_vars(vars)
    vars_buffer = ""
    vars.each do |key, value|
      vars_buffer += ", " if vars_buffer.length > 0
      vars_buffer += "?" + key.to_s
    end
    vars_buffer
  end

  def combine_statements(statements)
    statements_buffer = ""
    statements.each do |statement|
      statements_buffer += "\n" if statements_buffer.length > 0
      statements_buffer += statement.to_s
    end
    statements_buffer
  end

  def order_clause(order_by, ascending)
    clause = ''
    if true == ascending
      clause = "\nORDER BY ?#{order_by.to_s}"
    else
      clause = "\nORDER BY DESC(?#{order_by.to_s})"
    end

    clause
  end

  def build_select_distinct(distict_vars, statements_buffer)
    query = "SELECT DISTINCT(#{distict_vars})
             FROM <#{DEFAULT_GRAPH_URI}> 
             WHERE { 
               #{statements_buffer} 
             }"
    query
  end

  def build_select_normal(vars_buffer, statements_buffer, filter_buffer)
    query = "SELECT #{vars_buffer} 
             FROM <#{DEFAULT_GRAPH_URI}> 
             WHERE { 
               #{statements_buffer}
               #{filter_buffer} 
             }"
    query
  end

  def build_query(vars_buffer, statements_buffer, filter, order_by, limit, offset, ascending, distinct = false, distict_vars = nil)
    filter_buffer = ''
    filter_buffer = "FILTER ( #{filter} )" if !filter.nil?

    if true == distinct
      query = build_select_distinct(distict_vars, statements_buffer)
    else
      query = build_select_normal(vars_buffer, statements_buffer, filter_buffer)
    end

    query += order_clause(order_by, ascending) if !order_by.nil?

    query += "\nLIMIT #{limit}" if !limit.nil?
    query += "\nOFFSET #{offset}" if !offset.nil?
    query
  end

  ###############################################################################################
  # Extracción de resultados

  def decode_json_row(bound_variables, binding)
    row = Hash.new
    bound_variables.each do |key, value|
      if binding.has_key?(key.to_s)
        if value == RDF::URI
          row[key] = RDF::URI.new(binding[key.to_s]["value"])
        elsif value == RDF::Literal
          row[key] = RDF::Literal.new(binding[key.to_s]["value"].encode('UTF-8'))
        end
      end
    end
    row
  end

  def decode_json_results(raw_json, bound_variables)
    result_set = Array.new
    json = JSON.parse(raw_json)

    json["results"]["bindings"].each do |binding|
      row = RdfQuery::decode_json_row(bound_variables, binding)
      result_set << row if !row.empty?
    end
    result_set
  end


  ###############################################################################################
  # Metodos capa intermedia

  def execute_select(vars, statements, order_by = nil, limit = 20, offset = 0, ascending = true)
    vars_buffer = combine_vars(vars)
    statements_buffer = combine_statements(statements)

    query = build_query(vars_buffer, statements_buffer, nil, order_by, limit, offset, ascending)

    json_result = sparql_query(query)
    RdfQuery::decode_json_results(json_result, vars)
  end


  def count(statements, filter = nil)
    Rails.logger.debug("RdfQuery::count") if @@trace_on == true

    statements_buffer = combine_statements(statements)

    filter_buffer = ''
    filter_buffer = "FILTER ( #{filter} )" if !filter.nil?

    query = "SELECT COUNT(*) AS ?count WHERE {
      {
        SELECT ?entity
        FROM <#{DEFAULT_GRAPH_URI}>
        WHERE {
      	  #{statements_buffer}
      	  #{filter_buffer}
        }
      }
    }"

    json_result = sparql_query(query)
    RdfQuery::decode_count(json_result)
  end

  def decode_count(raw_json)
    Rails.logger.debug("RdfQuery::decode_count") if @@trace_on == true

    count = 0
    result_set = Array.new
    json = JSON.parse(raw_json)

    json["results"]["bindings"].each do |binding|
      if binding.has_key?("count")
        count = Integer(binding["count"]["value"])
      end
    end

    Rails.logger.debug("RdfQuery::decode_count returning #{count}") if @@trace_on == true
    count
  end

  def max(vars, count_var, statements)
    Rails.logger.debug("RdfQuery::max") if @@trace_on == true

    vars_buffer = combine_vars(vars)
    statements_buffer = combine_statements(statements)

    query = "SELECT MAX(?#{count_var.to_s}) AS ?max_id WHERE {
      {
        SELECT #{vars_buffer}
        FROM <#{DEFAULT_GRAPH_URI}>
        WHERE {
      	  #{statements_buffer}
        }
      }
    }"

    json_result = sparql_query(query)
    RdfQuery::decode_max(json_result)
  end

  def decode_max(json_result)
    max = 0
    result_set = Array.new
    json = JSON.parse(json_result)

    json["results"]["bindings"].each do |binding|
      if binding.has_key?("max_id")
        max = binding["max_id"]["value"].to_i
      end
    end

    Rails.logger.debug("RdfQuery::decode_max returning #{max}") if @@trace_on == true
    max
  end

  ###############################################################################################
  # Metodos para manejar literales

  def get_literal(rdf_uri, predicate)
    Rails.logger.debug("RdfQuery::get_literal(#{rdf_uri}, #{predicate})") if @@trace_on == true

    vars = Hash[:literal => RDF::Literal]
    statements = Array.[](
                          "<#{rdf_uri}> <#{predicate}> ?literal"
                          )
    rows = execute_select(vars, statements, nil, nil, nil)

    Rails.logger.debug("RdfQuery::get_literal json_result = #{rows}") if @@trace_on == true

    literal = nil
    literal = RDF::Literal.new(rows[0][:literal]) if !rows.empty?
    literal
  end

  def insert_literal(rdf_uri, predicate, literal, execute = true)
    Rails.logger.debug("RdrQuery::insert_literal #{literal}, which is a #{literal.class} and is canonically #{literal.canonicalize}") if true == @@trace_on

    if literal.plain? || literal.datatype.to_s == "http://www.w3.org/2001/XMLSchema#dateTime" || literal.datatype.to_s == "http://www.w3.org/2001/XMLSchema#date"
      literal = "\"" + literal.to_s + "\"" 
    elsif literal.datatype.to_s == "http://www.w3.org/2001/XMLSchema#boolean"
      literal = "\"" + literal.to_s + "\"^^<" + literal.datatype.to_s + ">"
    end

    statement = RDF::Statement.new(rdf_uri, predicate, literal)

    query = "INSERT INTO GRAPH <#{DEFAULT_GRAPH_URI}> { #{statement} }"
    Rails.logger.debug("RdfQuery::insert_literal: #{query}") if true == @@trace_on

    result = RdfQuery::sparql_query(query, SPARQL_ENDPOINT) if execute
  end
 
  def update_literal(rdf_uri, predicate, literal)
    if literal.plain? || literal.datatype.to_s == "http://www.w3.org/2001/XMLSchema#dateTime" || literal.datatype.to_s == "http://www.w3.org/2001/XMLSchema#date"
      literal = "\"" + literal.to_s + "\""
    elsif literal.datatype.to_s == "http://www.w3.org/2001/XMLSchema#boolean"
      literal = "\"" + literal.to_s + "\"^^<" + literal.datatype.to_s + ">"
    end

    query = "MODIFY <#{DEFAULT_GRAPH_URI}>
               DELETE { <#{rdf_uri}> <#{predicate}> ?name }
               INSERT { <#{rdf_uri}> <#{predicate}> #{literal} }
             WHERE { OPTIONAL { <#{rdf_uri}> <#{predicate}> ?name } }"

    result = sparql_query(query, SPARQL_ENDPOINT)
  end

  def delete_literal(rdf_uri, predicate)
    statement = RDF::Statement.new(rdf_uri, predicate, "?literal")
    query = "DELETE FROM GRAPH <#{DEFAULT_GRAPH_URI}> { #{statement} }
      FROM <#{DEFAULT_GRAPH_URI}>
      WHERE { #{statement} }"

    result = sparql_query(query, SPARQL_ENDPOINT)
  end


  ###############################################################################################
  # Metodos para manejar URIs

  def get_uri(rdf_uri, predicate)
    Rails.logger.debug("RdfQuery::get_uri(#{rdf_uri}, #{predicate})") if @@trace_on == true

    vars = Hash[:uri => RDF::URI]
    statements = Array.[](
                          "<#{rdf_uri}> <#{predicate}> ?uri"
                          )
    rows = execute_select(vars, statements, nil, nil, nil)

    Rails.logger.debug("RdfQuery::get_uri json_result = #{rows}") if @@trace_on == true

    uri = nil
    uri = RDF::URI.new(rows[0][:uri]) if !rows.empty?
    uri
  end

  def insert_uri(rdf_uri, predicate, uri, execute = true)
    statement = RDF::Statement.new(rdf_uri, predicate, uri)

    query = "INSERT INTO GRAPH <#{DEFAULT_GRAPH_URI}> { #{statement} }"
    Rails.logger.debug("RdfQuery::insert_uri #{query}") if true == @@trace_on
    
    result = sparql_query(query, SPARQL_ENDPOINT) if execute
  end
 
  def update_uri(rdf_uri, predicate, uri)
    query = "MODIFY <#{DEFAULT_GRAPH_URI}>
               DELETE { <#{rdf_uri}> <#{predicate}> ?name }
               INSERT { <#{rdf_uri}> <#{predicate}> <#{uri}> }
             WHERE { OPTIONAL { <#{rdf_uri}> <#{predicate}> ?name } }"

    result = sparql_query(query, SPARQL_ENDPOINT)
  end

  def delete_uri(rdf_uri, predicate, uri = "?uri")
    statement = RDF::Statement.new(rdf_uri, predicate, uri)
    query = "DELETE FROM GRAPH <#{DEFAULT_GRAPH_URI}> { #{statement} }
      FROM <#{DEFAULT_GRAPH_URI}>
      WHERE { #{statement} }"

    result = sparql_query(query, SPARQL_ENDPOINT)
  end
 

  ############################################################################
  # Funciones que exportamos

  module_function :sparql_query
  module_function :combine_vars
  module_function :combine_statements
  module_function :build_select_normal
  module_function :build_select_distinct
  module_function :order_clause
  module_function :build_query
  module_function :execute_select

  module_function :decode_json_row
  module_function :decode_json_results

  module_function :count
  module_function :decode_count

  module_function :max
  module_function :decode_max

  # operations on literals
  module_function :get_literal
#  module_function :parse_find_literal
  module_function :insert_literal
  module_function :update_literal
  module_function :delete_literal

  # operations on URIs
  module_function :get_uri
#  module_function :parse_find_literal
  module_function :insert_uri
  module_function :update_uri
  module_function :delete_uri

end
