require 'test_helper'

class TpGeneratedParamsControllerTest < ActionController::TestCase
  setup do
    @tp_generated_param = tp_generated_params(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tp_generated_params)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tp_generated_param" do
    assert_difference('TpGeneratedParam.count') do
      post :create, tp_generated_param: @tp_generated_param.attributes
    end

    assert_redirected_to tp_generated_param_path(assigns(:tp_generated_param))
  end

  test "should show tp_generated_param" do
    get :show, id: @tp_generated_param.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tp_generated_param.to_param
    assert_response :success
  end

  test "should update tp_generated_param" do
    put :update, id: @tp_generated_param.to_param, tp_generated_param: @tp_generated_param.attributes
    assert_redirected_to tp_generated_param_path(assigns(:tp_generated_param))
  end

  test "should destroy tp_generated_param" do
    assert_difference('TpGeneratedParam.count', -1) do
      delete :destroy, id: @tp_generated_param.to_param
    end

    assert_redirected_to tp_generated_params_path
  end
end
