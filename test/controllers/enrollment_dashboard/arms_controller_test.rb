require 'test_helper'

module EnrollmentDashboard
  class ArmsControllerTest < ActionController::TestCase
    setup do
      @arm = arms(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:arms)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create arm" do
      assert_difference('Arm.count') do
        post :create, arm: { name: @arm.name, project_id: @arm.project_id }
      end

      assert_redirected_to arm_path(assigns(:arm))
    end

    test "should show arm" do
      get :show, id: @arm
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @arm
      assert_response :success
    end

    test "should update arm" do
      patch :update, id: @arm, arm: { name: @arm.name, project_id: @arm.project_id }
      assert_redirected_to arm_path(assigns(:arm))
    end

    test "should destroy arm" do
      assert_difference('Arm.count', -1) do
        delete :destroy, id: @arm
      end

      assert_redirected_to arms_path
    end
  end
end
