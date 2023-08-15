class CreateImages < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :images do |t|
      t.string :title

      t.timestamps
    end
  end
end
