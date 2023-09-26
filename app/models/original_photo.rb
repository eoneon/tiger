require "./app/uploaders/image_uploader"

class OriginalPhoto < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :photo
end
