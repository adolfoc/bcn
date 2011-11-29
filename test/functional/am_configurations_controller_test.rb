require 'test_helper'

class AmConfigurationsControllerTest < ActionController::TestCase
  setup do
    @am_configuration = am_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:am_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create am_configuration" do
    assert_difference('AmConfiguration.count') do
      post :create, am_configuration: @am_configuration.attributes
    end

    assert_redirected_to am_configuration_path(assigns(:am_configuration))
  end

  test "should show am_configuration" do
    get :show, id: @am_configuration.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @am_configuration.to_param
    assert_response :success
  end

  test "should update am_configuration" do
    put :update, id: @am_configuration.to_param, am_configuration: @am_configuration.attributes
    assert_redirected_to am_configuration_path(assigns(:am_configuration))
  end

  test "should destroy am_configuration" do
    assert_difference('AmConfiguration.count', -1) do
      delete :destroy, id: @am_configuration.to_param
    end

    assert_redirected_to am_configurations_path
  end
end
