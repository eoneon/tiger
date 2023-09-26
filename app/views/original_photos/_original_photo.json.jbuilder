json.extract! original_photo, :id, :image_data, :photo_id, :created_at, :updated_at
json.url original_photo_url(original_photo, format: :json)
