class CreateSatellites < ActiveRecord::Migration[7.1]
  def change
    create_table :satellites do |t|
      t.integer :id_sat
      t.string :name_sat

      t.timestamps
    end
  end
end
