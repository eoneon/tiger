require 'active_support/concern'
module Search
  extend ActiveSupport::Concern

  class_methods do

    def index_query(hstore, *keys)
      format_params(keys).any? ? where("#{hstore.to_s}?& ARRAY[:keys]", keys: format_params(keys)) : all
    end

    def hstore_query(param_hsh, hstore="tags")
      search_params(param_hsh, hstore).any? ? where(search_params(param_hsh, hstore).to_a.map{|kv| hstore_params(kv[0], kv[1], hstore)}.join(" AND ")) : all
    end

    def hstore_params(k,v, hstore)
      "#{hstore} -> \'#{k}\' = \'#{v}\'"
    end

    def search_params(param_hsh, hstore)
      if hattr_params = param_hsh.dig(hstore)
        format_params(search_params)
      else
        {}
      end
    end

    def format_params(search_params)
      search_params.is_a?(Array) ? search_params.reject {|i| i.empty?} : search_params.reject {|k,v| v.blank?}
    end
  end
end
