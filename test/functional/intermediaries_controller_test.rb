require 'test_helper'

class IntermediariesControllerTest < ActionController::TestCase
  setup do
    @intermediary = intermediaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:intermediaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create intermediary" do
    assert_difference('Intermediary.count') do
      post :create, intermediary: @intermediary.attributes
    end

    assert_redirected_to intermediary_path(assigns(:intermediary))
  end

  test "should show intermediary" do
    get :show, id: @intermediary.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @intermediary.to_param
    assert_response :success
  end

  test "should update intermediary" do
    put :update, id: @intermediary.to_param, intermediary: @intermediary.attributes
    assert_redirected_to intermediary_path(assigns(:intermediary))
  end

  test "should destroy intermediary" do
    assert_difference('Intermediary.count', -1) do
      delete :destroy, id: @intermediary.to_param
    end

    assert_redirected_to intermediaries_path
  end
end
