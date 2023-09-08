require "./app/uploaders/image_uploader"

class Photo < ApplicationRecord
  include Search
  include Sort
  include Hashable
  include ImageUploader::Attachment(:image)
  attr_accessor :page

  validates :title, presence: true

  before_save :valid_checkbox_vals
  before_create :set_sort

  private

  def set_sort
    self.sort = Photo.max_sort + 1
  end

  def valid_checkbox_vals
    self.tags.reject!{|k,v| k != v}
  end

end
