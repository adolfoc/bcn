require 'test_helper'

class PoblamientoGeneratedParamsControllerTest < ActionController::TestCase
  setup do
    @poblamiento_generated_param = poblamiento_generated_params(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poblamiento_generated_params)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poblamiento_generated_param" do
    assert_difference('PoblamientoGeneratedParam.count') do
      post :create, poblamiento_generated_param: @poblamiento_generated_param.attributes
    end

    assert_redirected_to poblamiento_generated_param_path(assigns(:poblamiento_generated_param))
  end

  test "should show poblamiento_generated_param" do
    get :show, id: @poblamiento_generated_param.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poblamiento_generated_param.to_param
    assert_response :success
  end

  test "should update poblamiento_generated_param" do
    put :update, id: @poblamiento_generated_param.to_param, poblamiento_generated_param: @poblamiento_generated_param.attributes
    assert_redirected_to poblamiento_generated_param_path(assigns(:poblamiento_generated_param))
  end

  test "should destroy poblamiento_generated_param" do
    assert_difference('PoblamientoGeneratedParam.count', -1) do
      delete :destroy, id: @poblamiento_generated_param.to_param
    end

    assert_redirected_to poblamiento_generated_params_path
  end
end
