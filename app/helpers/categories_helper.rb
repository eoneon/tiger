module CategoriesHelper
  def name_and_val
    Category.all.pluck(:category_name, :id).each_with_object({}) do |name_and_id, hsh|
      hsh[name_and_id[0]] = name_and_id[1].to_s
    end
  end

  def category_filter
    Category.all.group_by{|i| i.category_type}
  end 
end
