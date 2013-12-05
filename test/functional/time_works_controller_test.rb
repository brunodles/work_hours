# -*- encoding : utf-8 -*-
require 'test_helper'

class TimeWorksControllerTest < ActionController::TestCase
  setup do
    @time_work = time_works(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_works)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_work" do
    assert_difference('TimeWork.count') do
      post :create, time_work: { begin_at: @time_work.begin_at, deleted_at: @time_work.deleted_at, description: @time_work.description, end_at: @time_work.end_at, is_open: @time_work.is_open, project_id: @time_work.project_id, user_id: @time_work.user_id }
    end

    assert_redirected_to time_work_path(assigns(:time_work))
  end

  test "should show time_work" do
    get :show, id: @time_work
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_work
    assert_response :success
  end

  test "should update time_work" do
    put :update, id: @time_work, time_work: { begin_at: @time_work.begin_at, deleted_at: @time_work.deleted_at, description: @time_work.description, end_at: @time_work.end_at, is_open: @time_work.is_open, project_id: @time_work.project_id, user_id: @time_work.user_id }
    assert_redirected_to time_work_path(assigns(:time_work))
  end

  test "should destroy time_work" do
    assert_difference('TimeWork.count', -1) do
      delete :destroy, id: @time_work
    end

    assert_redirected_to time_works_path
  end
end
