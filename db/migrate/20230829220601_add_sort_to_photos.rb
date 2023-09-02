class AddSortToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :sort, :integer
  end
end
