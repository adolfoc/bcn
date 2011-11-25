require 'test_helper'

class AmRunObservationTypesControllerTest < ActionController::TestCase
  setup do
    @am_run_observation_type = am_run_observation_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:am_run_observation_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create am_run_observation_type" do
    assert_difference('AmRunObservationType.count') do
      post :create, am_run_observation_type: @am_run_observation_type.attributes
    end

    assert_redirected_to am_run_observation_type_path(assigns(:am_run_observation_type))
  end

  test "should show am_run_observation_type" do
    get :show, id: @am_run_observation_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @am_run_observation_type.to_param
    assert_response :success
  end

  test "should update am_run_observation_type" do
    put :update, id: @am_run_observation_type.to_param, am_run_observation_type: @am_run_observation_type.attributes
    assert_redirected_to am_run_observation_type_path(assigns(:am_run_observation_type))
  end

  test "should destroy am_run_observation_type" do
    assert_difference('AmRunObservationType.count', -1) do
      delete :destroy, id: @am_run_observation_type.to_param
    end

    assert_redirected_to am_run_observation_types_path
  end
end
