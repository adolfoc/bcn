require 'test_helper'

class ParticipationTypesControllerTest < ActionController::TestCase
  setup do
    @participation_type = participation_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:participation_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participation_type" do
    assert_difference('ParticipationType.count') do
      post :create, participation_type: @participation_type.attributes
    end

    assert_redirected_to participation_type_path(assigns(:participation_type))
  end

  test "should show participation_type" do
    get :show, id: @participation_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participation_type.to_param
    assert_response :success
  end

  test "should update participation_type" do
    put :update, id: @participation_type.to_param, participation_type: @participation_type.attributes
    assert_redirected_to participation_type_path(assigns(:participation_type))
  end

  test "should destroy participation_type" do
    assert_difference('ParticipationType.count', -1) do
      delete :destroy, id: @participation_type.to_param
    end

    assert_redirected_to participation_types_path
  end
end
