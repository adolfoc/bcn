require 'test_helper'

class TaskTransitionsControllerTest < ActionController::TestCase
  setup do
    @task_transition = task_transitions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_transitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_transition" do
    assert_difference('TaskTransition.count') do
      post :create, task_transition: @task_transition.attributes
    end

    assert_redirected_to task_transition_path(assigns(:task_transition))
  end

  test "should show task_transition" do
    get :show, id: @task_transition.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_transition.to_param
    assert_response :success
  end

  test "should update task_transition" do
    put :update, id: @task_transition.to_param, task_transition: @task_transition.attributes
    assert_redirected_to task_transition_path(assigns(:task_transition))
  end

  test "should destroy task_transition" do
    assert_difference('TaskTransition.count', -1) do
      delete :destroy, id: @task_transition.to_param
    end

    assert_redirected_to task_transitions_path
  end
end
