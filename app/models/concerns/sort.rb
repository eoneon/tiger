require 'active_support/concern'
module Sort
  extend ActiveSupport::Concern

  class_methods do

    # def sort_up
    #   photo = Photo.find(params[:id])
    #   Photo.swap_sort(photo, -1)
    #
    #   respond_to do |format|
    #     format.js {render file: "/photos/index.js.erb"}
    #   end
    # end
    #
    # def sort_down
    #   photo = Photo.find(params[:id])
    #   Photo.swap_sort(photo, 1)
    #
    #   respond_to do |format|
    #     format.js {render file: "/photos/index.js.erb"}
    #   end
    # end

    # def destroy
    #   sort = @photo.sort
    #
    #   if @photo.destroy
    #     reset_sort(sort)
    #
    #     respond_to do |format|
    #       format.js {render file: "/photos/index.js.erb"}
    #     end
    #   end
    # end

    def swap_sort(photo, pos)
      sort = photo.sort
      sort2 = pos == -1 ? sort - 1 : sort + 1
      photo2 = where(sort: sort2)
      photo2.update(sort: photo.sort)
      photo.update(sort: sort2)
    end

    def reset_sort(sort)
      where("sort > ?", sort).each do |photo|
        photo.update(sort: photo.sort - 1)
      end
    end


    def initial_sort
      all.each_with_index do |photo, i|
        photo.update(sort: (i+1))
      end
    end

    def sort_pagination_params(photos: nil, limit: 9)
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
