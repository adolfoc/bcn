require 'test_helper'

class DocTypeAmConfigurationsControllerTest < ActionController::TestCase
  setup do
    @doc_type_am_configuration = doc_type_am_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:doc_type_am_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doc_type_am_configuration" do
    assert_difference('DocTypeAmConfiguration.count') do
      post :create, doc_type_am_configuration: @doc_type_am_configuration.attributes
    end

    assert_redirected_to doc_type_am_configuration_path(assigns(:doc_type_am_configuration))
  end

  test "should show doc_type_am_configuration" do
    get :show, id: @doc_type_am_configuration.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @doc_type_am_configuration.to_param
    assert_response :success
  end

  test "should update doc_type_am_configuration" do
    put :update, id: @doc_type_am_configuration.to_param, doc_type_am_configuration: @doc_type_am_configuration.attributes
    assert_redirected_to doc_type_am_configuration_path(assigns(:doc_type_am_configuration))
  end

  test "should destroy doc_type_am_configuration" do
    assert_difference('DocTypeAmConfiguration.count', -1) do
      delete :destroy, id: @doc_type_am_configuration.to_param
    end

    assert_redirected_to doc_type_am_configurations_path
  end
end
