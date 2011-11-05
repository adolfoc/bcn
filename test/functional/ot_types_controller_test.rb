require 'test_helper'

class OtTypesControllerTest < ActionController::TestCase
  setup do
    @ot_type = ot_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ot_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ot_type" do
    assert_difference('OtType.count') do
      post :create, ot_type: @ot_type.attributes
    end

    assert_redirected_to ot_type_path(assigns(:ot_type))
  end

  test "should show ot_type" do
    get :show, id: @ot_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ot_type.to_param
    assert_response :success
  end

  test "should update ot_type" do
    put :update, id: @ot_type.to_param, ot_type: @ot_type.attributes
    assert_redirected_to ot_type_path(assigns(:ot_type))
  end

  test "should destroy ot_type" do
    assert_difference('OtType.count', -1) do
      delete :destroy, id: @ot_type.to_param
    end

    assert_redirected_to ot_types_path
  end
end
