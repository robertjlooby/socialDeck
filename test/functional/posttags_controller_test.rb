require 'test_helper'

class PosttagsControllerTest < ActionController::TestCase
  setup do
    @posttag = posttags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posttags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create posttag" do
    assert_difference('Posttag.count') do
      post :create, posttag: { post_id: @posttag.post_id, tag_id: @posttag.tag_id }
    end

    assert_redirected_to posttag_path(assigns(:posttag))
  end

  test "should show posttag" do
    get :show, id: @posttag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @posttag
    assert_response :success
  end

  test "should update posttag" do
    put :update, id: @posttag, posttag: { post_id: @posttag.post_id, tag_id: @posttag.tag_id }
    assert_redirected_to posttag_path(assigns(:posttag))
  end

  test "should destroy posttag" do
    assert_difference('Posttag.count', -1) do
      delete :destroy, id: @posttag
    end

    assert_redirected_to posttags_path
  end
end
