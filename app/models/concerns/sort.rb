require 'active_support/concern'
module Sort
  extend ActiveSupport::Concern

  class_methods do

    def initial_sort
      all.each_with_index do |photo, i|
        photo.update(sort: (i+1))
      end
    end

    def sort_pagination_params(photos: nil, limit: 12)
      sorts, a = sort_vals(photos), []
      (sorts[-1].to_f/limit).ceil.times do |i|
        a << {sort: sorts.take(limit), page: (i+1)}
        sorts = sorts.drop(limit)
        return a if sorts.none?
      end
      a
    end

    def sort_vals(photos=nil)
      sorted_photos(photos).pluck(:sort)
    end

    def sorted_photos(photos=nil)
      (photos ? photos : all).order(:sort)
    end

    def max_sort
      maximum(:sort)
    end
  end
end
