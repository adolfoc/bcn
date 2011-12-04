require 'test_helper'

class TargetDocumentVersionsControllerTest < ActionController::TestCase
  setup do
    @target_document_version = target_document_versions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:target_document_versions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create target_document_version" do
    assert_difference('TargetDocumentVersion.count') do
      post :create, target_document_version: @target_document_version.attributes
    end

    assert_redirected_to target_document_version_path(assigns(:target_document_version))
  end

  test "should show target_document_version" do
    get :show, id: @target_document_version.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @target_document_version.to_param
    assert_response :success
  end

  test "should update target_document_version" do
    put :update, id: @target_document_version.to_param, target_document_version: @target_document_version.attributes
    assert_redirected_to target_document_version_path(assigns(:target_document_version))
  end

  test "should destroy target_document_version" do
    assert_difference('TargetDocumentVersion.count', -1) do
      delete :destroy, id: @target_document_version.to_param
    end

    assert_redirected_to target_document_versions_path
  end
end
