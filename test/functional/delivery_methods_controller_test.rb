require 'test_helper'

class DeliveryMethodsControllerTest < ActionController::TestCase
  setup do
    @delivery_method = delivery_methods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_methods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_method" do
    assert_difference('DeliveryMethod.count') do
      post :create, delivery_method: @delivery_method.attributes
    end

    assert_redirected_to delivery_method_path(assigns(:delivery_method))
  end

  test "should show delivery_method" do
    get :show, id: @delivery_method.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery_method.to_param
    assert_response :success
  end

  test "should update delivery_method" do
    put :update, id: @delivery_method.to_param, delivery_method: @delivery_method.attributes
    assert_redirected_to delivery_method_path(assigns(:delivery_method))
  end

  test "should destroy delivery_method" do
    assert_difference('DeliveryMethod.count', -1) do
      delete :destroy, id: @delivery_method.to_param
    end

    assert_redirected_to delivery_methods_path
  end
end
