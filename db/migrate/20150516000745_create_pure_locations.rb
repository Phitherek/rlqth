class CreatePureLocations < ActiveRecord::Migration
  def change
    create_table :pure_locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :locator

      t.timestamps null: false
    end
  end
end
