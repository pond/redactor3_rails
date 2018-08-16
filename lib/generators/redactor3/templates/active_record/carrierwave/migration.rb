class CreateRedactor3Assets < ActiveRecord::Migration
  def self.up
    create_table :redactor3_assets do |t|
      t.string :data_file_name, :null => false
      t.string :data_content_type
      t.integer :data_file_size

      t.integer :assetable_id
      t.string :assetable_type, :limit => 30
      t.string :type, :limit => 30

      t.integer :width
      t.integer :height

      t.timestamps
    end

    add_index 'redactor3_assets', ['assetable_type', 'type', 'assetable_id'], :name => 'idx_redactor3_assetable_type'
    add_index 'redactor3_assets', ['assetable_type', 'assetable_id'], :name => 'idx_redactor3_assetable'
  end

  def self.down
    drop_table :redactor3_assets
  end
end
