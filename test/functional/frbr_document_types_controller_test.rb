require 'test_helper'

class FrbrDocumentTypesControllerTest < ActionController::TestCase
  setup do
    @frbr_document_type = frbr_document_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frbr_document_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frbr_document_type" do
    assert_difference('FrbrDocumentType.count') do
      post :create, frbr_document_type: @frbr_document_type.attributes
    end

    assert_redirected_to frbr_document_type_path(assigns(:frbr_document_type))
  end

  test "should show frbr_document_type" do
    get :show, id: @frbr_document_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frbr_document_type.to_param
    assert_response :success
  end

  test "should update frbr_document_type" do
    put :update, id: @frbr_document_type.to_param, frbr_document_type: @frbr_document_type.attributes
    assert_redirected_to frbr_document_type_path(assigns(:frbr_document_type))
  end

  test "should destroy frbr_document_type" do
    assert_difference('FrbrDocumentType.count', -1) do
      delete :destroy, id: @frbr_document_type.to_param
    end

    assert_redirected_to frbr_document_types_path
  end
end
