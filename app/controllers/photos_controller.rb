class PhotosController < ApplicationController
  include Pundit::Authorization

  before_action :set_photo, only: %i[ show edit update destroy ]

  def index
    @photos_for_sidebar = Photo.all.order(:sort)
    @photos = @photos_for_sidebar.limit(9)
    @page, @tags = 1, nil

    authorize @photos
  end

  # GET /photos/1 or /photos/1.json
  def show
    @photo = Photo.find(params[:id])
    authorize @photo
  end

  # GET /photos/new
  def new
    @photo = Photo.new
    authorize @photo
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
    authorize @photo
  end

  # POST /photos or /photos.json
  def create
    @photo = Photo.new(photo_params)
    authorize @photo

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photos_path, notice: "Photo was successfully created." }
        format.json { render :index, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    @photo = Photo.find(params[:id])
    @photo.assign_attributes(photo_params)
    authorize @photo

    respond_to do |format|
      if @photo.save #update_attributes(photo_params)
        format.html { redirect_to photo_url(@photo), notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    authorize @photo
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit!
    end
end
