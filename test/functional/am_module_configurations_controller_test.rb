require 'test_helper'

class AmModuleConfigurationsControllerTest < ActionController::TestCase
  setup do
    @am_module_configuration = am_module_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:am_module_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create am_module_configuration" do
    assert_difference('AmModuleConfiguration.count') do
      post :create, am_module_configuration: @am_module_configuration.attributes
    end

    assert_redirected_to am_module_configuration_path(assigns(:am_module_configuration))
  end

  test "should show am_module_configuration" do
    get :show, id: @am_module_configuration.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @am_module_configuration.to_param
    assert_response :success
  end

  test "should update am_module_configuration" do
    put :update, id: @am_module_configuration.to_param, am_module_configuration: @am_module_configuration.attributes
    assert_redirected_to am_module_configuration_path(assigns(:am_module_configuration))
  end

  test "should destroy am_module_configuration" do
    assert_difference('AmModuleConfiguration.count', -1) do
      delete :destroy, id: @am_module_configuration.to_param
    end

    assert_redirected_to am_module_configurations_path
  end
end
