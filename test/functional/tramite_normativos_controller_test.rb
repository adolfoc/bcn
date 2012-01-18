require 'test_helper'

class TramiteNormativosControllerTest < ActionController::TestCase
  setup do
    @tramite_normativo = tramite_normativos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tramite_normativos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tramite_normativo" do
    assert_difference('TramiteNormativo.count') do
      post :create, tramite_normativo: @tramite_normativo.attributes
    end

    assert_redirected_to tramite_normativo_path(assigns(:tramite_normativo))
  end

  test "should show tramite_normativo" do
    get :show, id: @tramite_normativo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tramite_normativo.to_param
    assert_response :success
  end

  test "should update tramite_normativo" do
    put :update, id: @tramite_normativo.to_param, tramite_normativo: @tramite_normativo.attributes
    assert_redirected_to tramite_normativo_path(assigns(:tramite_normativo))
  end

  test "should destroy tramite_normativo" do
    assert_difference('TramiteNormativo.count', -1) do
      delete :destroy, id: @tramite_normativo.to_param
    end

    assert_redirected_to tramite_normativos_path
  end
end
