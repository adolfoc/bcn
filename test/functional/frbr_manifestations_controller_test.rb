require 'test_helper'

class FrbrManifestationsControllerTest < ActionController::TestCase
  setup do
    @frbr_manifestation = frbr_manifestations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frbr_manifestations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frbr_manifestation" do
    assert_difference('FrbrManifestation.count') do
      post :create, frbr_manifestation: @frbr_manifestation.attributes
    end

    assert_redirected_to frbr_manifestation_path(assigns(:frbr_manifestation))
  end

  test "should show frbr_manifestation" do
    get :show, id: @frbr_manifestation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frbr_manifestation.to_param
    assert_response :success
  end

  test "should update frbr_manifestation" do
    put :update, id: @frbr_manifestation.to_param, frbr_manifestation: @frbr_manifestation.attributes
    assert_redirected_to frbr_manifestation_path(assigns(:frbr_manifestation))
  end

  test "should destroy frbr_manifestation" do
    assert_difference('FrbrManifestation.count', -1) do
      delete :destroy, id: @frbr_manifestation.to_param
    end

    assert_redirected_to frbr_manifestations_path
  end
end
