require 'test_helper'

class AmObservationsControllerTest < ActionController::TestCase
  setup do
    @am_observation = am_observations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:am_observations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create am_observation" do
    assert_difference('AmObservation.count') do
      post :create, am_observation: @am_observation.attributes
    end

    assert_redirected_to am_observation_path(assigns(:am_observation))
  end

  test "should show am_observation" do
    get :show, id: @am_observation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @am_observation.to_param
    assert_response :success
  end

  test "should update am_observation" do
    put :update, id: @am_observation.to_param, am_observation: @am_observation.attributes
    assert_redirected_to am_observation_path(assigns(:am_observation))
  end

  test "should destroy am_observation" do
    assert_difference('AmObservation.count', -1) do
      delete :destroy, id: @am_observation.to_param
    end

    assert_redirected_to am_observations_path
  end
end
