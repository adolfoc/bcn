class AutomaticMarkup
  def self.create_target_expression(source)
    target_expression_params = Hash.new
    target_expression_params[:frbr_work_id] = source.frbr_expression.frbr_work_id
    target_expression_params[:frbr_document_type_id] = 3
    target_expression_params[:version] = 1
    target_expression_params[:language] = "es"

    target_expression = FrbrExpression.new(target_expression_params)
    target_expression.save
    target_expression
  end

  def self.create_target_manifestation(target_expression, target_filename)
    target_manifestation_params = Hash.new
    target_manifestation_params[:frbr_expression_id] = target_expression.id
    target_manifestation_params[:document_file_name] = target_filename
    target_manifestation_params[:document_content_type] = "text/xml"
    target_manifestation_params[:document_file_size] = 213145
    target_manifestation_params[:document_updated_at] = DateTime.now

    target_manifestation = FrbrManifestation.new(target_manifestation_params)
    target_manifestation.save
    target_manifestation
  end

  def self.generate_initial_markup(source_frbr_manifestation_id)
    source = FrbrManifestation.find(source_frbr_manifestation_id)
    target_filename = source.document_file_name.chomp(File.extname(source.document_file_name)) + '.xml'

    target_expression = AutomaticMarkup.create_target_expression(source)
    target_manifestation = create_target_manifestation(target_expression, target_filename)

    # Copy the source to the target
    Dir.mkdir("#{Rails.root.to_s}/public/system/documents/#{target_manifestation.id.to_s}")
    Dir.mkdir("#{Rails.root.to_s}/public/system/documents/#{target_manifestation.id.to_s}/original")

    source = File.open("#{Rails.root.to_s}/public/system/documents/#{source.id.to_s}/original/#{source.document_file_name}")
    target = File.open("#{Rails.root.to_s}/public/system/documents/#{target_manifestation.id.to_s}/original/#{target_filename}", "w+b")

    target.write(source.read(1024)) while !source.eof?
    source.close
    target.close

    target_manifestation
  end
end
