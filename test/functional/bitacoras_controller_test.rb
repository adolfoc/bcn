require 'test_helper'

class BitacorasControllerTest < ActionController::TestCase
  setup do
    @bitacora = bitacoras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bitacoras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bitacora" do
    assert_difference('Bitacora.count') do
      post :create, bitacora: @bitacora.attributes
    end

    assert_redirected_to bitacora_path(assigns(:bitacora))
  end

  test "should show bitacora" do
    get :show, id: @bitacora.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bitacora.to_param
    assert_response :success
  end

  test "should update bitacora" do
    put :update, id: @bitacora.to_param, bitacora: @bitacora.attributes
    assert_redirected_to bitacora_path(assigns(:bitacora))
  end

  test "should destroy bitacora" do
    assert_difference('Bitacora.count', -1) do
      delete :destroy, id: @bitacora.to_param
    end

    assert_redirected_to bitacoras_path
  end
end
