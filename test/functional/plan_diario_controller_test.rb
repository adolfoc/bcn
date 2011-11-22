require 'test_helper'

class PlanDiarioControllerTest < ActionController::TestCase
  test "should get perform_work" do
    get :perform_work
    assert_response :success
  end

  test "should get eligiendo_documento" do
    get :eligiendo_documento
    assert_response :success
  end

  test "should get asignando_tareas" do
    get :asignando_tareas
    assert_response :success
  end

  test "should get notificar_analista" do
    get :notificar_analista
    assert_response :success
  end

end
