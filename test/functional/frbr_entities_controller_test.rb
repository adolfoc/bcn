require 'test_helper'

class FrbrEntitiesControllerTest < ActionController::TestCase
  setup do
    @frbr_entity = frbr_entities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frbr_entities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frbr_entity" do
    assert_difference('FrbrEntity.count') do
      post :create, frbr_entity: @frbr_entity.attributes
    end

    assert_redirected_to frbr_entity_path(assigns(:frbr_entity))
  end

  test "should show frbr_entity" do
    get :show, id: @frbr_entity.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frbr_entity.to_param
    assert_response :success
  end

  test "should update frbr_entity" do
    put :update, id: @frbr_entity.to_param, frbr_entity: @frbr_entity.attributes
    assert_redirected_to frbr_entity_path(assigns(:frbr_entity))
  end

  test "should destroy frbr_entity" do
    assert_difference('FrbrEntity.count', -1) do
      delete :destroy, id: @frbr_entity.to_param
    end

    assert_redirected_to frbr_entities_path
  end
end
