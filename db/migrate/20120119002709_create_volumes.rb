class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.string :name
      t.string :media_type
      t.string :capacity
      t.string :index

      t.timestamps
    end
  end
end
