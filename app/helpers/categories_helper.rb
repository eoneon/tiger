module CategoriesHelper
  def name_and_val
    Category.all.pluck(:category_name, :id).each_with_object({}) do |name_and_id, hsh|
      hsh[name_and_id[0]] = name_and_id[1].to_s
    end
  end

  def category_filter
    Category.all.group_by{|i| i.category_type}
  end

  def category_count(photos, category)
    Photo.hattr_index_query(photos, {"tags" =>category.id.to_s}).count
  end

  def category_header(displayed_photos, total_photos, category)
    "Showing #{displayed_photos.count} of #{total_photos.count} Clips from #{(category ? category.category_type+": "+category.category_name : "All Photos")}"
  end
end
