module SortPhotosHelper
  def sort_up(photo)
    photo.sort.present? && photo.sort > 1
  end

  def sort_down(photo)
    photo.sort.present? && photo.sort < Photo.max_sort
  end
end
