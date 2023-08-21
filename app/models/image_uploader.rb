require "image_processing/mini_magick"

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick

  #plugin :derivatives
  plugin :validation_helpers
  plugin :determine_mime_type
  #plugin :instrumentation
  plugin :processing
  plugin :versions
  plugin :delete_raw
  plugin :store_dimensions #, analyzer: :mini_magick

  # process(:store) do |io, context|
  #   { original: io, thumb: resize_to_limit!(io.download, 300, 300) }
  # end

  # Attacher.derivatives do |original|
  #   magick = ImageProcessing::MiniMagick.source(original)
  #
  #   {
  #     large:  magick.resize_to_limit!(800, 800),
  #     medium: magick.resize_to_limit!(500, 500),
  #     small:  magick.resize_to_limit!(300, 300),
  #   }
  # end

  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png image/webp]
    validate_max_size  1*1024*1024
  end
end
