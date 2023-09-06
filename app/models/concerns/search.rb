require 'active_support/concern'
module Search
  extend ActiveSupport::Concern

  class_methods do

    def search_index_with_pagination(search_params)
      pagination_set = hattr_index_query(all, search_params[:hstor]).order(:sort)
      [pagination_set, attr_index_query(pagination_set, search_params[:attrs])]
    end

    def hattr_index_query(set, hstor_params)
      hstor_params && hstor_params.values.any? ? set.where("#{hstor_params.keys[0].to_s}?& ARRAY[:keys]", keys: hstor_params.values) : set
    end

    def attr_index_query(set, attr_params)
      attr_params && attr_params.values.any? ? set.where(attr_params) : set
    end


    # hstore query/params methods ##############################################
    #data: {name: category.category_name, type: category.category_type, count: category_count(photos, category)}
    # def index_search(search_params)
    #   set = hattr_index_query(all, search_params[:hstor])
    #   attr_index_query(set, search_params[:attrs])
    # end

    # def index_query(hstore, *keys)
    #   format_params(keys).any? ? where("#{hstore.to_s}?& ARRAY[:keys]", keys: format_params(keys)) : all
    # end
    #
    # def hstore_query(param_hsh, hstore="tags")
    #   search_params(param_hsh, hstore).any? ? where(search_params(param_hsh, hstore).to_a.map{|kv| hstore_params(kv[0], kv[1], hstore)}.join(" AND ")) : all
    # end
    #
    # def hstore_params(k,v, hstore)
    #   "#{hstore} -> \'#{k}\' = \'#{v}\'"
    # end
    #
    # def search_params(param_hsh, hstore)
    #   if hattr_params = param_hsh.dig(hstore)
    #     format_params(search_params)
    #   else
    #     {}
    #   end
    # end
    #
    # def format_params(search_params)
    #   search_params.is_a?(Array) ? search_params.reject {|i| i.empty?} : search_params.reject {|k,v| v.blank?}
    # end

    def update_tags
      all.each do |photo|
        if tags = photo.tags
          photo.tags = swap_tags(tags.keys) unless tags.empty?
          photo.save
        end
      end
    end

    def swap_tags(keys)
      Category.where(category_name: keys).pluck(:id).compact.each_with_object({}) do |id, tags|
        tags[id.to_s] = id.to_s
      end
    end
  end
end
