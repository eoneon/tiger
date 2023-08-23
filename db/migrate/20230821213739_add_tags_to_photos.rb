class AddTagsToPhotos < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    add_column :photos, :tags, :hstore
  end
end
