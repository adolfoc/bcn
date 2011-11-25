require 'test_helper'

class AmResultsControllerTest < ActionController::TestCase
  setup do
    @am_result = am_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:am_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create am_result" do
    assert_difference('AmResult.count') do
      post :create, am_result: @am_result.attributes
    end

    assert_redirected_to am_result_path(assigns(:am_result))
  end

  test "should show am_result" do
    get :show, id: @am_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @am_result.to_param
    assert_response :success
  end

  test "should update am_result" do
    put :update, id: @am_result.to_param, am_result: @am_result.attributes
    assert_redirected_to am_result_path(assigns(:am_result))
  end

  test "should destroy am_result" do
    assert_difference('AmResult.count', -1) do
      delete :destroy, id: @am_result.to_param
    end

    assert_redirected_to am_results_path
  end
end
