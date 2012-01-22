class RemoveMediaTypeFromVolume < ActiveRecord::Migration
  def up
    remove_column :volumes, :media_type
  end
  
  def down
    add_column :volumes, :media_type, :string
  end
end
