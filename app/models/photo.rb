class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image) # adds an `image` virtual attribute
  validates :title, presence: true
end
