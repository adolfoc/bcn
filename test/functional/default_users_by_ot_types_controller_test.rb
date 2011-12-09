require 'test_helper'

class DefaultUsersByOtTypesControllerTest < ActionController::TestCase
  setup do
    @default_users_by_ot_type = default_users_by_ot_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:default_users_by_ot_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create default_users_by_ot_type" do
    assert_difference('DefaultUsersByOtType.count') do
      post :create, default_users_by_ot_type: @default_users_by_ot_type.attributes
    end

    assert_redirected_to default_users_by_ot_type_path(assigns(:default_users_by_ot_type))
  end

  test "should show default_users_by_ot_type" do
    get :show, id: @default_users_by_ot_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @default_users_by_ot_type.to_param
    assert_response :success
  end

  test "should update default_users_by_ot_type" do
    put :update, id: @default_users_by_ot_type.to_param, default_users_by_ot_type: @default_users_by_ot_type.attributes
    assert_redirected_to default_users_by_ot_type_path(assigns(:default_users_by_ot_type))
  end

  test "should destroy default_users_by_ot_type" do
    assert_difference('DefaultUsersByOtType.count', -1) do
      delete :destroy, id: @default_users_by_ot_type.to_param
    end

    assert_redirected_to default_users_by_ot_types_path
  end
end
