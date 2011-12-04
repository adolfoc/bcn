module AmConfigurationMock
  # Generate a new skeleton configuration for automatic markup
  # TODO: Should be based on previous run
  def generate_skeleton_am_configuration(ot_id)
    am_configuration = AmConfiguration.new

    am_configuration.structural_markup_enabled = true
    am_configuration.structural_markup_extension_whole_document = true
    am_configuration.structural_markup_depth_all = true
    am_configuration.semantic_markup_enabled = true
    am_configuration.semantic_markup_extension_whole_document = true
    am_configuration.semantic_markup_depth_all = true

    am_configuration
  end
end
