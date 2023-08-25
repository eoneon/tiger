module PhotosHelper
  def selected_checkbox(photo, tag_name)
    photo.tags && photo.tags["#{tag_name}"] == tag_name ? true : false
  end
end
