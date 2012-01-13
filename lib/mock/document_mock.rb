module DocumentMock
  def create_source_document_template
    frbr_work = FrbrWork.new
    
    frbr_expression = FrbrExpression.new({ :frbr_document_type_id => 3, :version => 1, :language => 'es' })
    frbr_work.frbr_expressions << frbr_expression
    
    frbr_manifestation = FrbrManifestation.new
    frbr_expression.frbr_manifestations << frbr_manifestation

    frbr_work
  end

  def get_dummy_text
    frbr_manifestation = FrbrManifestation.find(@ot.target_frbr_manifestation_id)
    File.open("#{Rails.root.to_s}/public/system/documents/#{frbr_manifestation.id.to_s}/original/#{frbr_manifestation.document_file_name}", 'r') { |f| f.read }
  end

  # If we don't have an XML file, create one
  def check_for_target_document
    Rails.logger.debug("$$$ DocumentMock::check_for_target_document")
    if @ot.target_frbr_manifestation_id.nil?
      target_frbr = AutomaticMarkup.generate_initial_markup(@ot.source_frbr_manifestation_id)

      params = Hash.new
      params[:target_frbr_manifestation_id] = target_frbr.id
      @ot.update_attributes(params)
    end
  end
end
