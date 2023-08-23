class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image) # adds an `image` virtual attribute
  validates :title, presence: true

  before_save :valid_checkbox_vals

  private
  
  def valid_checkbox_vals
    self.tags.reject!{|k,v| k != v}
  end
end
