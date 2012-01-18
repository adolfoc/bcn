require 'test_helper'

class TramiteConstitucionalsControllerTest < ActionController::TestCase
  setup do
    @tramite_constitucional = tramite_constitucionals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tramite_constitucionals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tramite_constitucional" do
    assert_difference('TramiteConstitucional.count') do
      post :create, tramite_constitucional: @tramite_constitucional.attributes
    end

    assert_redirected_to tramite_constitucional_path(assigns(:tramite_constitucional))
  end

  test "should show tramite_constitucional" do
    get :show, id: @tramite_constitucional.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tramite_constitucional.to_param
    assert_response :success
  end

  test "should update tramite_constitucional" do
    put :update, id: @tramite_constitucional.to_param, tramite_constitucional: @tramite_constitucional.attributes
    assert_redirected_to tramite_constitucional_path(assigns(:tramite_constitucional))
  end

  test "should destroy tramite_constitucional" do
    assert_difference('TramiteConstitucional.count', -1) do
      delete :destroy, id: @tramite_constitucional.to_param
    end

    assert_redirected_to tramite_constitucionals_path
  end
end
