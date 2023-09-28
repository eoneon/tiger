class OriginalPhotosController < ApplicationController
  before_action :set_original_photo, only: %i[ show edit update destroy ]
  before_action :set_photo, only: %i[ new create destroy]
  # GET /original_photos/1 or /original_photos/1.json
  def show
  end

  # GET /original_photos/new
  def new
    @original_photo = OriginalPhoto.new
  end

  # GET /original_photos/1/edit
  def edit
  end

  # POST /original_photos or /original_photos.json
  def create
    #@original_photo = OriginalPhoto.new
    @original_photo = @photo.build_original_photo(original_photo_params)

    respond_to do |format|
      if @original_photo.save
        format.html { redirect_to original_photo_url(@original_photo), notice: "Original photo was successfully created." }
        format.json { render :show, status: :created, location: @original_photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @original_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /original_photos/1 or /original_photos/1.json
  def update
    respond_to do |format|
      if @original_photo.update(original_photo_params)
        format.html { redirect_to original_photo_url(@original_photo), notice: "Original photo was successfully updated." }
        format.json { render :show, status: :ok, location: @original_photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @original_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /original_photos/1 or /original_photos/1.json
  def destroy
    @original_photo.destroy

    respond_to do |format|
      format.html { redirect_to @photo, notice: "Original photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_original_photo
      @original_photo = OriginalPhoto.find(params[:id])
    end

    def set_photo
      @photo = Photo.find(params[:photo_id])
    end

    # Only allow a list of trusted parameters through.
    def original_photo_params
      params.require(:original_photo).permit(:image, :photo_id)
    end
end
