require 'test_helper'

class FrbrExpressionsControllerTest < ActionController::TestCase
  setup do
    @frbr_expression = frbr_expressions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frbr_expressions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frbr_expression" do
    assert_difference('FrbrExpression.count') do
      post :create, frbr_expression: @frbr_expression.attributes
    end

    assert_redirected_to frbr_expression_path(assigns(:frbr_expression))
  end

  test "should show frbr_expression" do
    get :show, id: @frbr_expression.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frbr_expression.to_param
    assert_response :success
  end

  test "should update frbr_expression" do
    put :update, id: @frbr_expression.to_param, frbr_expression: @frbr_expression.attributes
    assert_redirected_to frbr_expression_path(assigns(:frbr_expression))
  end

  test "should destroy frbr_expression" do
    assert_difference('FrbrExpression.count', -1) do
      delete :destroy, id: @frbr_expression.to_param
    end

    assert_redirected_to frbr_expressions_path
  end
end
