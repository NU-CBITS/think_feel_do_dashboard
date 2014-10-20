require 'test_helper'

module EnrollmentDashboard
  class EnrollmentsControllerTest < ActionController::TestCase
    setup do
      @enrollment = enrollments(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:enrollments)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create enrollment" do
      assert_difference('Enrollment.count') do
        post :create, enrollment: { coach_id: @enrollment.coach_id, display_name: @enrollment.display_name, group_id: @enrollment.group_id, participant_id: @enrollment.participant_id }
      end

      assert_redirected_to enrollment_path(assigns(:enrollment))
    end

    test "should show enrollment" do
      get :show, id: @enrollment
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @enrollment
      assert_response :success
    end

    test "should update enrollment" do
      patch :update, id: @enrollment, enrollment: { coach_id: @enrollment.coach_id, display_name: @enrollment.display_name, group_id: @enrollment.group_id, participant_id: @enrollment.participant_id }
      assert_redirected_to enrollment_path(assigns(:enrollment))
    end

    test "should destroy enrollment" do
      assert_difference('Enrollment.count', -1) do
        delete :destroy, id: @enrollment
      end

      assert_redirected_to enrollments_path
    end
  end
end
