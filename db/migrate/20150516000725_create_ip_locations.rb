class CreateIpLocations < ActiveRecord::Migration
  def change
    create_table :ip_locations do |t|
      t.string :ip
      t.float :latitude
      t.float :longitude
      t.string :locator

      t.timestamps null: false
    end
  end
end
