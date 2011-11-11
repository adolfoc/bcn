require 'test_helper'

class OtStatesControllerTest < ActionController::TestCase
  setup do
    @ot_state = ot_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ot_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ot_state" do
    assert_difference('OtState.count') do
      post :create, ot_state: @ot_state.attributes
    end

    assert_redirected_to ot_state_path(assigns(:ot_state))
  end

  test "should show ot_state" do
    get :show, id: @ot_state.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ot_state.to_param
    assert_response :success
  end

  test "should update ot_state" do
    put :update, id: @ot_state.to_param, ot_state: @ot_state.attributes
    assert_redirected_to ot_state_path(assigns(:ot_state))
  end

  test "should destroy ot_state" do
    assert_difference('OtState.count', -1) do
      delete :destroy, id: @ot_state.to_param
    end

    assert_redirected_to ot_states_path
  end
end
