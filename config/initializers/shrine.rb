require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/memory"
#require "shrine/storage/s3"

if  Rails.env.test?
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new,
  }
else
 Shrine.storages = {
   cache: Shrine::Storage::FileSystem.new("public", prefix:     "uploads/cache"), # temporary
   store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent
 }
end

Shrine.plugin :activerecord    # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data  # extracts metadata for assigned cached files
Shrine.plugin :determine_mime_type
Shrine.plugin :instrumentation
Shrine.plugin :validation
Shrine.plugin :validation_helpers

# Shrine.plugin :derivatives,
#   create_on_promote:      true, # automatically create derivatives on promotion
#   versions_compatibility: true  # handle versions column format
