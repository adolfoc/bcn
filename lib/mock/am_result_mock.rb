require 'am_observation_mock'

module AmResultMock
  include AmObservationMock

  def mock_up_am_results
    params = Hash.new
    params[:run_date] = DateTime.now
    params[:ot_id] = @ot.id
    am_result = AmResult.new(params)
    am_result.save

    create_random_am_warning(am_result.id)
    create_random_am_observation(am_result.id)
    create_random_am_error(am_result.id)
  end
end
