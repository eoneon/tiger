class SearchPhotosController < ApplicationController
  def index
    @photos = Photo.index_query("tags", search_params)

    respond_to do |format|
      format.js 
    end

  end

  private

  def search_params
    params[:photo][:tags]
  end
end

# @photos = Photo.hstore_query(search_params, "tags")
# def search_params
#   p_hsh = params[:photo].to_unsafe_h
#   p_hsh["tags"].blank? ? p_hsh : {p_hsh["tags"] => p_hsh["tags"]}
# end
