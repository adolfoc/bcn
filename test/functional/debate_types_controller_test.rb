require 'test_helper'

class DebateTypesControllerTest < ActionController::TestCase
  setup do
    @debate_type = debate_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debate_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debate_type" do
    assert_difference('DebateType.count') do
      post :create, debate_type: @debate_type.attributes
    end

    assert_redirected_to debate_type_path(assigns(:debate_type))
  end

  test "should show debate_type" do
    get :show, id: @debate_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debate_type.to_param
    assert_response :success
  end

  test "should update debate_type" do
    put :update, id: @debate_type.to_param, debate_type: @debate_type.attributes
    assert_redirected_to debate_type_path(assigns(:debate_type))
  end

  test "should destroy debate_type" do
    assert_difference('DebateType.count', -1) do
      delete :destroy, id: @debate_type.to_param
    end

    assert_redirected_to debate_types_path
  end
end
