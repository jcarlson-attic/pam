class ChangeVolumeNameToLabel < ActiveRecord::Migration
  def change
    rename_column :volumes, :name, :label
  end
end
