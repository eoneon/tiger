class CreateOriginalPhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :original_photos do |t|
      t.string :image_data
      t.references :photo, index: true, foreign_key: true

      t.timestamps
    end
  end
end
