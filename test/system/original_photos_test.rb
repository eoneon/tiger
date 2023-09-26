require "application_system_test_case"

class OriginalPhotosTest < ApplicationSystemTestCase
  setup do
    @original_photo = original_photos(:one)
  end

  test "visiting the index" do
    visit original_photos_url
    assert_selector "h1", text: "Original photos"
  end

  test "should create original photo" do
    visit original_photos_url
    click_on "New original photo"

    fill_in "Image data", with: @original_photo.image_data
    fill_in "Photo", with: @original_photo.photo_id
    click_on "Create Original photo"

    assert_text "Original photo was successfully created"
    click_on "Back"
  end

  test "should update Original photo" do
    visit original_photo_url(@original_photo)
    click_on "Edit this original photo", match: :first

    fill_in "Image data", with: @original_photo.image_data
    fill_in "Photo", with: @original_photo.photo_id
    click_on "Update Original photo"

    assert_text "Original photo was successfully updated"
    click_on "Back"
  end

  test "should destroy Original photo" do
    visit original_photo_url(@original_photo)
    click_on "Destroy this original photo", match: :first

    assert_text "Original photo was successfully destroyed"
  end
end
