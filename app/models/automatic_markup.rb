class AutomaticMarkup
  def self.generate_initial_markup(source_frbr_manifestation_id)
    Rails.logger.debug("$$$ AutomaticMarkup::generate_initial_markup")

    source = FrbrManifestation.find(source_frbr_manifestation_id)

    expression_params = Hash.new
    expression_params[:frbr_work_id] = source.frbr_expression.frbr_work_id
    expression_params[:frbr_document_type_id] = 3
    expression_params[:version] = 1
    expression_params[:language] = "es"
    target_expression = FrbrExpression.new(expression_params)
    target_expression.save

    target_filename = source.document_file_name.chomp(File.extname(source.document_file_name)) + '.xml'

    manifestation_params = Hash.new
    manifestation_params[:frbr_expression_id] = target_expression.id
    manifestation_params[:document_file_name] = target_filename
    manifestation_params[:document_content_type] = "text/xml"
    manifestation_params[:document_file_size] = 213145
    manifestation_params[:document_updated_at] = DateTime.now
    target_manifestation = FrbrManifestation.new(manifestation_params)
    target_manifestation.save

    # Copy the source to the target after ensuring that the target's extension is xml
    Dir.mkdir("#{Rails.root.to_s}/public/system/documents/#{target_manifestation.id.to_s}")
    Dir.mkdir("#{Rails.root.to_s}/public/system/documents/#{target_manifestation.id.to_s}/original")

    source = File.open("#{Rails.root.to_s}/public/system/documents/#{source.id.to_s}/original/#{source.document_file_name}")
    target = File.open("#{Rails.root.to_s}/public/system/documents/#{target_manifestation.id.to_s}/original/#{target_filename}", "w+b")

    target.write(source.read(1024)) while  !source.eof?
    source.close
    target.close

    target_manifestation
  end
end
