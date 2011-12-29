require 'test_helper'

class TpParametersControllerTest < ActionController::TestCase
  setup do
    @tp_parameter = tp_parameters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tp_parameters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tp_parameter" do
    assert_difference('TpParameter.count') do
      post :create, tp_parameter: @tp_parameter.attributes
    end

    assert_redirected_to tp_parameter_path(assigns(:tp_parameter))
  end

  test "should show tp_parameter" do
    get :show, id: @tp_parameter.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tp_parameter.to_param
    assert_response :success
  end

  test "should update tp_parameter" do
    put :update, id: @tp_parameter.to_param, tp_parameter: @tp_parameter.attributes
    assert_redirected_to tp_parameter_path(assigns(:tp_parameter))
  end

  test "should destroy tp_parameter" do
    assert_difference('TpParameter.count', -1) do
      delete :destroy, id: @tp_parameter.to_param
    end

    assert_redirected_to tp_parameters_path
  end
end
