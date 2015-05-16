class CreateAddressLocations < ActiveRecord::Migration
  def change
    create_table :address_locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :locator

      t.timestamps null: false
    end
  end
end
