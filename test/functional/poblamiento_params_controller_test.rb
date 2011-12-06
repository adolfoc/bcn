require 'test_helper'

class PoblamientoParamsControllerTest < ActionController::TestCase
  setup do
    @poblamiento_param = poblamiento_params(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poblamiento_params)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poblamiento_param" do
    assert_difference('PoblamientoParam.count') do
      post :create, poblamiento_param: @poblamiento_param.attributes
    end

    assert_redirected_to poblamiento_param_path(assigns(:poblamiento_param))
  end

  test "should show poblamiento_param" do
    get :show, id: @poblamiento_param.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poblamiento_param.to_param
    assert_response :success
  end

  test "should update poblamiento_param" do
    put :update, id: @poblamiento_param.to_param, poblamiento_param: @poblamiento_param.attributes
    assert_redirected_to poblamiento_param_path(assigns(:poblamiento_param))
  end

  test "should destroy poblamiento_param" do
    assert_difference('PoblamientoParam.count', -1) do
      delete :destroy, id: @poblamiento_param.to_param
    end

    assert_redirected_to poblamiento_params_path
  end
end
