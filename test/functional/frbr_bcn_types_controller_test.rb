require 'test_helper'

class FrbrBcnTypesControllerTest < ActionController::TestCase
  setup do
    @frbr_bcn_type = frbr_bcn_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frbr_bcn_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frbr_bcn_type" do
    assert_difference('FrbrBcnType.count') do
      post :create, frbr_bcn_type: @frbr_bcn_type.attributes
    end

    assert_redirected_to frbr_bcn_type_path(assigns(:frbr_bcn_type))
  end

  test "should show frbr_bcn_type" do
    get :show, id: @frbr_bcn_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frbr_bcn_type.to_param
    assert_response :success
  end

  test "should update frbr_bcn_type" do
    put :update, id: @frbr_bcn_type.to_param, frbr_bcn_type: @frbr_bcn_type.attributes
    assert_redirected_to frbr_bcn_type_path(assigns(:frbr_bcn_type))
  end

  test "should destroy frbr_bcn_type" do
    assert_difference('FrbrBcnType.count', -1) do
      delete :destroy, id: @frbr_bcn_type.to_param
    end

    assert_redirected_to frbr_bcn_types_path
  end
end
