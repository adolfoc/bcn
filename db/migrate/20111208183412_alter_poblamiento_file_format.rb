class AlterPoblamientoFileFormat < ActiveRecord::Migration
  def up
    rename_column :poblamiento_file_formats, :format, :format_spec
  end

  def down
    rename_column :poblamiento_file_formats, :format_spec, :format
  end
end
