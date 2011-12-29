require 'test_helper'

class TaxonomyCategoriesControllerTest < ActionController::TestCase
  setup do
    @taxonomy_category = taxonomy_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taxonomy_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taxonomy_category" do
    assert_difference('TaxonomyCategory.count') do
      post :create, taxonomy_category: @taxonomy_category.attributes
    end

    assert_redirected_to taxonomy_category_path(assigns(:taxonomy_category))
  end

  test "should show taxonomy_category" do
    get :show, id: @taxonomy_category.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @taxonomy_category.to_param
    assert_response :success
  end

  test "should update taxonomy_category" do
    put :update, id: @taxonomy_category.to_param, taxonomy_category: @taxonomy_category.attributes
    assert_redirected_to taxonomy_category_path(assigns(:taxonomy_category))
  end

  test "should destroy taxonomy_category" do
    assert_difference('TaxonomyCategory.count', -1) do
      delete :destroy, id: @taxonomy_category.to_param
    end

    assert_redirected_to taxonomy_categories_path
  end
end
