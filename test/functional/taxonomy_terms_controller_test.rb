require 'test_helper'

class TaxonomyTermsControllerTest < ActionController::TestCase
  setup do
    @taxonomy_term = taxonomy_terms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taxonomy_terms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taxonomy_term" do
    assert_difference('TaxonomyTerm.count') do
      post :create, taxonomy_term: @taxonomy_term.attributes
    end

    assert_redirected_to taxonomy_term_path(assigns(:taxonomy_term))
  end

  test "should show taxonomy_term" do
    get :show, id: @taxonomy_term.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @taxonomy_term.to_param
    assert_response :success
  end

  test "should update taxonomy_term" do
    put :update, id: @taxonomy_term.to_param, taxonomy_term: @taxonomy_term.attributes
    assert_redirected_to taxonomy_term_path(assigns(:taxonomy_term))
  end

  test "should destroy taxonomy_term" do
    assert_difference('TaxonomyTerm.count', -1) do
      delete :destroy, id: @taxonomy_term.to_param
    end

    assert_redirected_to taxonomy_terms_path
  end
end
