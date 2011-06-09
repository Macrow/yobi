require 'test_helper'

class Admin::ImagesControllerTest < ActionController::TestCase
  setup do
    @admin_image = admin_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_image" do
    assert_difference('Admin::Image.count') do
      post :create, :admin_image => @admin_image.attributes
    end

    assert_redirected_to admin_image_path(assigns(:admin_image))
  end

  test "should show admin_image" do
    get :show, :id => @admin_image.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_image.to_param
    assert_response :success
  end

  test "should update admin_image" do
    put :update, :id => @admin_image.to_param, :admin_image => @admin_image.attributes
    assert_redirected_to admin_image_path(assigns(:admin_image))
  end

  test "should destroy admin_image" do
    assert_difference('Admin::Image.count', -1) do
      delete :destroy, :id => @admin_image.to_param
    end

    assert_redirected_to admin_images_path
  end
end
