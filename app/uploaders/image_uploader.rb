require "./config/shrine"
require "image_processing/vips"
require "./lib/generate_thumbnail"

class ImageUploader < Shrine
  ALLOWED_TYPES  = %w[image/jpeg image/png image/webp]
  MAX_SIZE       = 10*1024*1024
  MAX_DIMENSIONS = [5000, 5000]

  THUMBNAILS = {
    small:  [300, 300],
    medium: [600, 600],
    large:  [950, 950],
  }

  plugin :remove_attachment
  plugin :pretty_location
  plugin :validation_helpers
  plugin :store_dimensions, analyzer: :fastimage, log_subscriber: nil
  plugin :derivatives, create_on_promote: true
  plugin :default_url
  plugin :derivation_endpoint, prefix: "derivations/image"

  # File validations (requires `validation_helpers` plugin)
  Attacher.validate do
    validate_size 0..MAX_SIZE

    if validate_mime_type ALLOWED_TYPES
      validate_max_dimensions MAX_DIMENSIONS
    end
  end

  # Thumbnails processor (requires `derivatives` plugin)
  Attacher.derivatives do |original|
    THUMBNAILS.transform_values do |(width, height)|
      GenerateThumbnail.call(original, width, height)
    end
  end

  # Default to dynamic thumbnail URL (requires `default_url` plugin)
  Attacher.default_url do |derivative: nil, **|
    file&.derivation_url(:thumbnail, *THUMBNAILS.fetch(derivative)) if derivative
  end

  # Dynamic thumbnail definition (requires `derivation_endpoint` plugin)
  derivation :thumbnail do |file, width, height|
    GenerateThumbnail.call(file, width.to_i, height.to_i)
  end
end
