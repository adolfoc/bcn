# -*- coding: utf-8 -*-
require 'rdf_query'

# Este módulo genera métodos a través de meta-programming para facilitar 
# la declaración de variables de instancia en clases que modelan estructuras RDF.
# Requiere que la clase que incluye este módulo defina una variable de instancia
# denominada +rdf_uri+ que representa el URI del sujeto.
# Trabajamos con los siguientes tipos de variables:
# * *literales* son nodos que contienen en general strings.
# * *uris* son nodos que contienen URIs, en general todos los sujetos y predicados.
# * *blank* *nodes* para relaciones entre clases en el grafo RDF.
# * *uri* *collections* para multivalores en relaciones 1 a muchos.

module RdfAccessor
  RDF_TYPE_URI =                'http://www.w3.org/1999/02/22-rdf-syntax-ns#type'

  @@accessor_trace_on = true

  def rdf_literal_accessor(name, rdf_predicate_uri)
    class_eval %Q{
      def #{name}
        if @#{name}.nil?
          Rails.logger.debug("rdf_literal_accessor::#{name}") if @@accessor_trace_on == true
          literal = RdfQuery::get_literal(@rdf_uri, \"#{rdf_predicate_uri}\")
          Rails.logger.debug("rdf_literal_accessor::#{name} got [" + literal.to_s + "]") if @@accessor_trace_on == true
          @#{name} = literal if !literal.nil?
        end
        @#{name}
      end

      def #{name}=(value)
        validate_literal(value)
        @#{name} = value
      end

      def #{name}_create
        insert_literal_with(@#{name}, \"#{rdf_predicate_uri}\")
      end

      def #{name}_update(new_value)
        update_literal_with(#{name}, \"#{rdf_predicate_uri}\", new_value)
      end

      def #{name}_destroy
        delete_literal_with(\"#{rdf_predicate_uri}\")
      end
  }
  end

  def validate_literal(literal_value)
    raise "Expecting RDF::Literal" if literal_value.class != RDF::Literal && literal_value.class != RDF::Literal::Boolean
  end

  def insert_literal_with(instance_variable, predicate)
    Rails.logger.debug("RdfAccessor::insert_literal_with(#{instance_variable}, #{predicate})") if @@accessor_trace_on == true
    RdfQuery::insert_literal(@rdf_uri, predicate, instance_variable)
  end

  def update_literal_with(instance_variable, predicate, new_value)
    Rails.logger.debug("RdfAccessor::update_literal_with(#{instance_variable}, #{predicate}, #{new_value})") if @@accessor_trace_on == true
    if new_value.to_s != instance_variable.to_s
      Rails.logger.debug("RdfAccessor:update_literal_with(#{instance_variable} != #{new_value})") if @@accessor_trace_on == true
      instance_variable = new_value
      RdfQuery::update_literal(@rdf_uri, predicate, instance_variable)
    end
  end

  def delete_literal_with(predicate)
    Rails.logger.debug("RdfAccessor::delete_literal_with(#{predicate})") if @@accessor_trace_on == true
    instance_variable = nil
    RdfQuery::delete_literal(@rdf_uri, predicate)
  end


  ############################################################################
  # Para accesar URIs

  def rdf_uri_accessor(name, rdf_predicate_uri)
    class_eval %Q{
      def #{name}
        if @#{name}.nil?
          Rails.logger.debug("rdf_uri_accessor::#{name}") if @@accessor_trace_on == true
          uri = RdfQuery::get_uri(@rdf_uri, \"#{rdf_predicate_uri}\")
          Rails.logger.debug("rdf_uri_accessor::#{name} got [" + uri.to_s + "]") if @@accessor_trace_on == true
          @#{name} = uri if !uri.nil?
        end
        @#{name}
      end

      def #{name}=(value)
        validate_uri(value)
        @#{name} = value
      end

      def #{name}_create
        insert_uri_with(@#{name}, \"#{rdf_predicate_uri}\")
      end

      def #{name}_update(new_value)
        update_uri_with(#{name}, \"#{rdf_predicate_uri}\", new_value)
      end

      def #{name}_destroy
        delete_uri_with(\"#{rdf_predicate_uri}\")
      end
  }
  end


  ############################################################################
  # Para accesar colecciones de URIs

  def rdf_uri_array_accessor(name, rdf_predicate_uri)
    class_eval %Q{
      def #{name}
        if @#{name}.nil? || 0 == @#{name}.length
          uri_array = RdfQuery::get_uri_array(@rdf_uri, \"#{rdf_predicate_uri}\")
          Rails.logger.debug('RdfAccessor::rdf_uri_array_accessor got ' + uri_array.inspect.to_s) if @@accessor_trace_on == true
          @#{name} = uri_array if uri_array.length > 0
        end
        @#{name}
      end

      def #{name}=(value)
        @#{name} = value
      end

      def #{name}_update(new_value)
        update_uri_array_with(@#{name}, \"#{rdf_predicate_uri}\", new_value)
      end
  }
  end

  ############################################################################
  # Funciones que exportamos

  module_function :rdf_literal_accessor
  module_function :rdf_uri_accessor
  module_function :rdf_uri_array_accessor
end
