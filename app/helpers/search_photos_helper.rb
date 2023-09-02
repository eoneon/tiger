module SearchPhotosHelper
  def is_active(i, page)
    "active" if i==page
  end
end
