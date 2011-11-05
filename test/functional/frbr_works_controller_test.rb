require 'test_helper'

class FrbrWorksControllerTest < ActionController::TestCase
  setup do
    @frbr_work = frbr_works(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frbr_works)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frbr_work" do
    assert_difference('FrbrWork.count') do
      post :create, frbr_work: @frbr_work.attributes
    end

    assert_redirected_to frbr_work_path(assigns(:frbr_work))
  end

  test "should show frbr_work" do
    get :show, id: @frbr_work.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frbr_work.to_param
    assert_response :success
  end

  test "should update frbr_work" do
    put :update, id: @frbr_work.to_param, frbr_work: @frbr_work.attributes
    assert_redirected_to frbr_work_path(assigns(:frbr_work))
  end

  test "should destroy frbr_work" do
    assert_difference('FrbrWork.count', -1) do
      delete :destroy, id: @frbr_work.to_param
    end

    assert_redirected_to frbr_works_path
  end
end
