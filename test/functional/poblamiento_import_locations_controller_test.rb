require 'test_helper'

class PoblamientoImportLocationsControllerTest < ActionController::TestCase
  setup do
    @poblamiento_import_location = poblamiento_import_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poblamiento_import_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poblamiento_import_location" do
    assert_difference('PoblamientoImportLocation.count') do
      post :create, poblamiento_import_location: @poblamiento_import_location.attributes
    end

    assert_redirected_to poblamiento_import_location_path(assigns(:poblamiento_import_location))
  end

  test "should show poblamiento_import_location" do
    get :show, id: @poblamiento_import_location.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poblamiento_import_location.to_param
    assert_response :success
  end

  test "should update poblamiento_import_location" do
    put :update, id: @poblamiento_import_location.to_param, poblamiento_import_location: @poblamiento_import_location.attributes
    assert_redirected_to poblamiento_import_location_path(assigns(:poblamiento_import_location))
  end

  test "should destroy poblamiento_import_location" do
    assert_difference('PoblamientoImportLocation.count', -1) do
      delete :destroy, id: @poblamiento_import_location.to_param
    end

    assert_redirected_to poblamiento_import_locations_path
  end
end
