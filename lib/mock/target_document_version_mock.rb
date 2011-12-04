module TargetDocumentVersionMock
  # Generate a new version of the marked up document after an editing session
  # or after running automatic markup
  def generate_new_document_version(markup_tool_index)
    params = Hash.new
    params[:ot_id] = @ot.id
    params[:user_id] = current_user.id
    params[:markup_tool_id] = markup_tool_index
    params[:version] = TargetDocumentVersion.next_version_for_ot(@ot.id)

    target_document = TargetDocumentVersion.new(params)
    target_document.save
  end
end
