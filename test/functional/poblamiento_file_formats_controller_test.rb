require 'test_helper'

class PoblamientoFileFormatsControllerTest < ActionController::TestCase
  setup do
    @poblamiento_file_format = poblamiento_file_formats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poblamiento_file_formats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poblamiento_file_format" do
    assert_difference('PoblamientoFileFormat.count') do
      post :create, poblamiento_file_format: @poblamiento_file_format.attributes
    end

    assert_redirected_to poblamiento_file_format_path(assigns(:poblamiento_file_format))
  end

  test "should show poblamiento_file_format" do
    get :show, id: @poblamiento_file_format.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poblamiento_file_format.to_param
    assert_response :success
  end

  test "should update poblamiento_file_format" do
    put :update, id: @poblamiento_file_format.to_param, poblamiento_file_format: @poblamiento_file_format.attributes
    assert_redirected_to poblamiento_file_format_path(assigns(:poblamiento_file_format))
  end

  test "should destroy poblamiento_file_format" do
    assert_difference('PoblamientoFileFormat.count', -1) do
      delete :destroy, id: @poblamiento_file_format.to_param
    end

    assert_redirected_to poblamiento_file_formats_path
  end
end
