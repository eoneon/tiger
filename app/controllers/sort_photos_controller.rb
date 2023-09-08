class SortPhotosController < ApplicationController

  def index
    @photos = Photo.all.order(:sort)
  end

  def update
    photo = Photo.find(params[:id])
    Photo.swap_sort(photo, params[:pos].to_i)
    @photos = Photo.all.order(:sort)
    
    respond_to do |format|
      format.js
    end
  end

end
