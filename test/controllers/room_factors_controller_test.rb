require 'test_helper'

class RoomFactorsControllerTest < ActionController::TestCase
  setup do
    @room_factor = room_factors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:room_factors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room_factor" do
    assert_difference('RoomFactor.count') do
      post :create, room_factor: {  }
    end

    assert_redirected_to room_factor_path(assigns(:room_factor))
  end

  test "should show room_factor" do
    get :show, id: @room_factor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @room_factor
    assert_response :success
  end

  test "should update room_factor" do
    patch :update, id: @room_factor, room_factor: {  }
    assert_redirected_to room_factor_path(assigns(:room_factor))
  end

  test "should destroy room_factor" do
    assert_difference('RoomFactor.count', -1) do
      delete :destroy, id: @room_factor
    end

    assert_redirected_to room_factors_path
  end
end
