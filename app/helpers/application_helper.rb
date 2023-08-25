module ApplicationHelper
  def dom_ref(*tags)
    tags.map{|tag| format_ref(tag)}.join("-")
  end

  def format_ref(tag)
    tag.respond_to?(:id) ? [obj_name(tag), tag.id].join("-") : tag.to_s
  end

  def obj_name(obj)
    obj.class.name.underscore
  end
end
