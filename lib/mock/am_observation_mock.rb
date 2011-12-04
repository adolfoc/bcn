module AmObservationMock
  def create_random_am_warning(am_result_id)
    obs_params = Hash.new
    obs_params[:am_result_id] = am_result_id
    obs_params[:am_run_observation_type_id] = AmRunObservationType::AM_OBSERVATION_TYPE_ADVERTENCIA
    obs_params[:line] = (Random.new.rand * 1000).to_i
    obs_params[:contents] = "Este es una advertencia del marcaje automatico"
    obs = AmObservation.new(obs_params)
    obs.save
    obs
  end

  def create_random_am_observation(am_result_id)
    obs_params = Hash.new
    obs_params[:am_result_id] = am_result_id
    obs_params[:am_run_observation_type_id] = AmRunObservationType::AM_OBSERVATION_TYPE_OBSERVACION
    obs_params[:line] = (Random.new.rand * 1000).to_i
    obs_params[:contents] = "Este es una observacion del marcaje automatico"
    obs = AmObservation.new(obs_params)
    obs.save
    obs
  end

  def create_random_am_error(am_result_id)
    obs_params = Hash.new
    obs_params[:am_result_id] = am_result_id
    obs_params[:am_run_observation_type_id] = AmRunObservationType::AM_OBSERVATION_TYPE_ERROR
    obs_params[:line] = (Random.new.rand * 1000).to_i
    obs_params[:contents] = "Este es un error del marcaje automatico"
    obs = AmObservation.new(obs_params)
    obs.save
    obs
  end
end
