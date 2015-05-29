class CreateReverseLocations < ActiveRecord::Migration
  def change
    create_table :reverse_locations do |t|
      t.string :locator
      t.float :latitude
      t.float :longitude
      t.string :reverse_address

      t.timestamps null: false
    end
  end
end
