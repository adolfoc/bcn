module AmMock
  require "savon"

  def package_am_results(am_configuration)
    mock_up_am_results
    am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    # Associate configuration with automatic marckup results
    am_configuration.am_result_id = am_result.id
    am_configuration.save

    am_result
  end

  # Fake the call
  def perform_am(am_configuration)
    # Need a document
    check_for_target_document

    am_result = package_am_results(am_configuration)

    # Mimic saving document to versioning repository
    generate_new_document_version(1)

    am_result
  end

  # Actually call the AM Web Service
  def perform_am_ws(am_configuration, ot)
    year = ot.source_frbr_manifestation.frbr_expression.frbr_work.event_date.year
    client = Savon::Client.new do
      wsdl.document = "http://172.18.21.14:18080/DemoMarcajeV2/services/Proceso?wsdl"
    end

    response = client.request(:ejecutarMarcajeConOntologia) do
      soap.body = { :data => ot.target_frbr_manifestation.as_text, :year => year }
    end

    if response.success?
      ot.target_frbr_manifestation.update_contents(response.body[:ejecutar_marcaje_con_ontologia_response][:ejecutar_marcaje_con_ontologia_return][:data])
    end

    am_result = package_am_results(am_configuration)

    # Mimic saving document to versioning repository
    generate_new_document_version(1)

    am_result
  end
end
