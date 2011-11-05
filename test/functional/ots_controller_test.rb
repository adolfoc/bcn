require 'test_helper'

class OtsControllerTest < ActionController::TestCase
  setup do
    @ot = ots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ot" do
    assert_difference('Ot.count') do
      post :create, ot: @ot.attributes
    end

    assert_redirected_to ot_path(assigns(:ot))
  end

  test "should show ot" do
    get :show, id: @ot.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ot.to_param
    assert_response :success
  end

  test "should update ot" do
    put :update, id: @ot.to_param, ot: @ot.attributes
    assert_redirected_to ot_path(assigns(:ot))
  end

  test "should destroy ot" do
    assert_difference('Ot.count', -1) do
      delete :destroy, id: @ot.to_param
    end

    assert_redirected_to ots_path
  end
end
