# -*- coding: utf-8 -*-

module RdfValidator
  def errors
    @errors = Hash.new if @errors.nil?
    @errors
  end

  # Un metodo helper para anadir a la cola un mensaje identificado por +key+.
  def add_error(key, message)
    if errors.key?(key)
      errors[key] << message
    else
      errors[key] = [message]
    end
  end

  # Validamos que el atributo esté presente
  def validate_attribute_pressence(attribute_symbol, attribute_value, message)
    add_error(attribute_symbol, message) if attribute_value.nil? || attribute_value.to_s.empty?
  end

  # Validamos que el atributo tenga un largo máximo
  def validate_attribute_length(attribute_symbol, attribute_value, max_chars, message)
    add_error(attribute_symbol, message) if attribute_value.nil? || attribute_value.to_s.empty? || attribute_value.to_s.length > max_chars
  end

  ############################################################################
  # Funciones que exportamos

  module_function :errors
  module_function :validate_attribute_pressence
  module_function :validate_attribute_length
end
