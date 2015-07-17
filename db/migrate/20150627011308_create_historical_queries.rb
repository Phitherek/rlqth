class CreateHistoricalQueries < ActiveRecord::Migration
  def change
    create_table :historical_queries do |t|
      t.belongs_to :remote_user
      t.belongs_to :location, polymorphic: true
      t.timestamps null: false
    end
  end
end
