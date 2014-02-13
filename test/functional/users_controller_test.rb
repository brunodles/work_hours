# -*- encoding : utf-8 -*-
require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { access_number: @user.access_number, deleted_at: @user.deleted_at, email: @user.email, last_access_at: @user.last_access_at, last_access_ip: @user.last_access_ip, logins: @user.login, name: @user.name, password: @user.password, password_recovery_at: @user.password_recovery_at, password_recovery_hash: @user.password_recovery_hash }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { access_number: @user.access_number, deleted_at: @user.deleted_at, email: @user.email, last_access_at: @user.last_access_at, last_access_ip: @user.last_access_ip, logins: @user.login, name: @user.name, password: @user.password, password_recovery_at: @user.password_recovery_at, password_recovery_hash: @user.password_recovery_hash }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
