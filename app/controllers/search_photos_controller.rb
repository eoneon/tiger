class SearchPhotosController < ApplicationController
  def index
    @nav_photos, @photos = Photo.search_index_with_pagination(search_params)
    @page, @tags = params[:page].to_i, params[:tags]
    set_category
    
    respond_to do |format|
      format.js
    end

  end

  private

  def search_params
    format_params
  end

  def set_category
    @category = params[:tags] && !params[:tags].blank? ? Category.find(params[:tags]) : nil
  end

  def format_params(param_keys: [:sort, :tags], hstor: :tags)
    param_keys.each_with_object({}) do |k,h|
      Photo.case_merge(h, params[k], (k==hstor ? :hstor : :attrs), k) unless params[k].blank?
    end
  end
end
