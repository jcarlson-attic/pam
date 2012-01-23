class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.string :label
      t.string :capacity

      t.timestamps
    end
  end
end
