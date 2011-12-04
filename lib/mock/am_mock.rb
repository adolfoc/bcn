module AmMock
  def perform_am(am_configuration)
    # Need a document
    check_for_target_document
    mock_up_am_results

    am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    # Associate configuration with automatic marckup results
    am_configuration.am_result_id = am_result.id
    am_configuration.save

    # Mimic saving document to versioning repository
    generate_new_document_version(1)

    am_result
  end
end
