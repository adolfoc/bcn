require 'test_helper'

class MarkupToolsControllerTest < ActionController::TestCase
  setup do
    @markup_tool = markup_tools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:markup_tools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create markup_tool" do
    assert_difference('MarkupTool.count') do
      post :create, markup_tool: @markup_tool.attributes
    end

    assert_redirected_to markup_tool_path(assigns(:markup_tool))
  end

  test "should show markup_tool" do
    get :show, id: @markup_tool.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @markup_tool.to_param
    assert_response :success
  end

  test "should update markup_tool" do
    put :update, id: @markup_tool.to_param, markup_tool: @markup_tool.attributes
    assert_redirected_to markup_tool_path(assigns(:markup_tool))
  end

  test "should destroy markup_tool" do
    assert_difference('MarkupTool.count', -1) do
      delete :destroy, id: @markup_tool.to_param
    end

    assert_redirected_to markup_tools_path
  end
end
