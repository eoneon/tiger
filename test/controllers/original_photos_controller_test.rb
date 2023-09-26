require "test_helper"

class OriginalPhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @original_photo = original_photos(:one)
  end

  test "should get index" do
    get original_photos_url
    assert_response :success
  end

  test "should get new" do
    get new_original_photo_url
    assert_response :success
  end

  test "should create original_photo" do
    assert_difference("OriginalPhoto.count") do
      post original_photos_url, params: { original_photo: { image_data: @original_photo.image_data, photo_id: @original_photo.photo_id } }
    end

    assert_redirected_to original_photo_url(OriginalPhoto.last)
  end

  test "should show original_photo" do
    get original_photo_url(@original_photo)
    assert_response :success
  end

  test "should get edit" do
    get edit_original_photo_url(@original_photo)
    assert_response :success
  end

  test "should update original_photo" do
    patch original_photo_url(@original_photo), params: { original_photo: { image_data: @original_photo.image_data, photo_id: @original_photo.photo_id } }
    assert_redirected_to original_photo_url(@original_photo)
  end

  test "should destroy original_photo" do
    assert_difference("OriginalPhoto.count", -1) do
      delete original_photo_url(@original_photo)
    end

    assert_redirected_to original_photos_url
  end
end
